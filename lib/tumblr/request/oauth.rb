require 'faraday'
require 'simple_oauth'

module SimpleOAuth
  class Header
    def signature_base
      #TODO Fix signature base
    end
  end
end

module Tumblr
  module Request
    class TumblrOAuth < Faraday::Middleware
      def call(env)
        params = env[:body] || {}
        signature_params = params
        params.each do |key, value|
          signature_params = {} if value.respond_to?(:content_type)
        end
        header = SimpleOAuth::Header.new(env[:method], env[:url], signature_params, @options)
        env[:request_headers]["Authorization"] = header.to_s
        env[:request_headers]["Content-type"] = "application/x-www-form-urlencoded"                                                                              
        env[:request_headers]["Host"] = "api.tumblr.com"
        @app.call(env)
      end

      def initialize(app, options={})
        @app, @options = app, options
      end
    end
  end
end
