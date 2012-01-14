require 'json'
require 'oauth'

module Tumblr
  module Request

    #Performs a get request
    def get(path, params={})
      response = connection.get do |req|
        req.url path 
        req.params = params
      end
      JSON.parse(response.body)
    end
    
    #Performs post request
    def post(path, params={})
      response = connection.post do |req|
        req.url path
        req.body = params unless params.empty?
      end
      JSON.parse(response.body)
    end
  end
end
