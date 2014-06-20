require 'vine_api/request'
require 'faraday'
require 'faraday_middleware'

module VineApi
  class User
    include VineApi::Request

    def initialize(email, password)
      data = post('/users/authenticate', :username => email, :password => password)
      @key = data['key'] 
    end

    def profile(user_id = nil)
      if user_id
        get("/users/profiles/#{user_id}")
      else
        get('/users/me')
      end
    end

    def timeline(user_id, page = 1)
      get("/timelines/users/#{user_id}?page=#{page}")
    end

    def tag(tag, page = 1)
      get("/timelines/tags/#{tag}?page=#{page}")
    end

    def notifications(user_id)
      get("/users/#{user_id}/pendingNotificationsCount")
    end

    def popular(page = 1)
      get("/timelines/popular?page=#{page}")
    end

    def logout
      delete('/users/authenticate')
    end
  end
end
