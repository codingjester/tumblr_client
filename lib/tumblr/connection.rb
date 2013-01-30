require 'faraday'
require 'faraday_middleware'
require 'tumblr/request/oauth'

module Tumblr
  module Connection
    def connection(options={})
      default_options = {
        :headers => {
          :accept => "application/json",
          :user_agent => "Tumblr v1.0"
        },
        :url => "http://api.tumblr.com/"
      }
      Faraday.new("http://api.tumblr.com/", default_options.merge(options)) do |builder|
        builder.use Tumblr::Request::TumblrOAuth, credentials unless credentials.empty?
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::ParseJson, :content_type => "application/json"
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end
