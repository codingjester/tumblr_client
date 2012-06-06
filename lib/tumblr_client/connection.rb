require 'faraday'
require 'faraday_middleware'

require 'tumblr_client/response/parse_json'

module Tumblr
  module Connection
    def connection(options={})
      return @connection if defined? @connection

      default_options = {
        :headers => {
          :accept => "application/json",
          :user_agent => "Tumblr v1.0"
        },
        :url => "http://api.tumblr.com/"
      }

      @connection = Faraday.new("http://api.tumblr.com/", default_options.merge(options)) do |builder|
        builder.use FaradayMiddleware::OAuth, credentials if !credentials.empty?
        builder.use Faraday::Request::UrlEncoded
        builder.use Tumblr::Response::ParseJson
        builder.adapter adapter
      end
    end
  end
end
