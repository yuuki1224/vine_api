# -*- coding: utf-8 -*-
require 'faraday'
require 'faraday_middleware'

module VineApi
  # このmoduleを読み込んで中のメソッドを実行
  module Request
    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    private
    def request(http_method, path, params = {})
      #Faradayオブジェクトのsendを使ってる
      response = connection.send(http_method.to_sym, path, params) do |request|
        request[:vine_session_id] = @key if @key
      end
 
      response.body['data']
    end

    def connection
      options = {
        :url => 'https://api.vineapp.com/',
        :headers => {
          :accept => 'application/json',
          :user_agent => "com.vine.iphone/1.0.3 (unknown, iPhone OS 6.1.0, iPhone, Scale/2.000000)",
        },
        :request => {
          :open_timeout => 5,
          :timeout => 10,
        },
        :ssl => {
          :verify => true
        },
      }
 
      Faraday.new(options) do |builder|
        builder.response :raise_error
       # builder.response :mashify
        builder.response :json
        builder.request :url_encoded
        builder.adapter :net_http
      end
    end
  end
  class VineError < StandardError
  end

  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        case env[:status].to_i
        when 400...600
          raise VineApi::VineError.new(error_message(env))
        end
      end

      private

      def error_message(env)
        [
          env[:method].to_s.upcase,
          env[:url].to_s,
          env[:status],
          error_body(env[:body])
        ].join(': ')
      end

      def error_body(body)
        if body.nil?
          nil
        elsif body['error']
          body['error']
        end
      end
    end
  end
  Faraday.register_middleware :response, :raise_error => lambda { VineApi::Response::RaiseError }
end
