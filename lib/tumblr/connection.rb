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
        :url => "http://#{api_host}/"
      }
      Faraday.new("http://#{api_host}/", default_options.merge(options)) do |builder|
        data = { :api_host => api_host }.merge(credentials)
        builder.use Tumblr::Request::TumblrOAuth, data unless credentials.empty?
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::ParseJson, :content_type => "application/json"
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end
