require 'faraday'
require 'faraday_middleware'
require 'tumblr/request/oauth'

module Tumblr
  module Connection

    def connection(options={})
      host = api_host
      default_options = {
        :headers => {
          :accept => 'application/json',
          :user_agent => "tumblr_client (ruby) - #{Tumblr::VERSION}"
        },
        :url => "http://#{host}/"
      }
      Faraday.new("http://#{host}/", default_options.merge(options)) do |builder|
        data = { :api_host => host }.merge(credentials)
        unless credentials.empty?
          builder.use Tumblr::Request::TumblrOAuth, data
        end
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::ParseJson, :content_type => 'application/json'
        builder.use Faraday::Adapter::NetHttp
      end
    end

  end
end
