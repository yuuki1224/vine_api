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

    def profile
      get('/users/me')
    end

    def timeline(user_id)
      get("/timelines/users/#{user_id}")
    end

    def tag(tag)
      get("/timelines/tags/#{tag}")
    end

    def notifications(user_id)
      get("/users/#{user_id}/pendingNotificationsCount")
    end

    def popular(user_id = nil)
      if user_id
        get("/users/profiles/#{user_id}")
      else
        get('/users/me')
      end
    end

    def logout
      delete('/users/authenticate')
    end
  end
end
