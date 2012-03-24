require 'json'

module Tumblr
  module Request

    #Performs a get request
    def get(path, params={})
      response = connection.get do |req|
        req.url path 
        req.params = params
      end
      #check for errors and encapsulate
      JSON.parse(response.body)['response']
    end
    
    #Performs post request
    def post(path, params={})
      response = connection.post do |req|
        req.url path
        req.body = params unless params.empty?
      end
      #Check for errors and encapsulate
      JSON.parse(response.body)['response']
    end
  end
end
