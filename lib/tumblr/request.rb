require 'json'

module Tumblr
  module Request

    #Performs a get request
    def get(path, params={})
      response = connection.get do |req|
        req.url path 
        req.params = params
      end
      #Check for errors and encapsulate
      respond(response)
    end
    
    #Performs post request
    def post(path, params={})
      response = connection.post do |req|
        req.url path
        req.body = params unless params.empty?
      end
      #Check for errors and encapsulate
      respond(response)
    end

    def respond(response)
      if [201, 200].include?(response.status)
        response.body['response']
      else
        response.body['meta']
      end
    end

    private :get, :post, :respond
    
  end
end
