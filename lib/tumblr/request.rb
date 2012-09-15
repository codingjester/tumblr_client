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
      if [201,200].include?(response.body['meta']['status'])
        response.body['response']
      else
        response.body['meta']
      end
    end
    
    #Performs post request
    def post(path, params={})
      response = connection.post do |req|
        req.url path
        req.body = params unless params.empty?
      end
      #Check for errors and encapsulate
      if [201,200].include?(response.body['meta']['status'])
        response.body['response']
      else
        response.body['meta']
      end
    end
    
  end
end
