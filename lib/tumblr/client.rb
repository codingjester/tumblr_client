require 'tumblr/blog'
require 'tumblr/user'
require 'tumblr/request'
require 'tumblr/connection'
require 'tumblr/post'
require 'tumblr/tagged'
require 'tumblr/helpers'

module Tumblr
  class Client

    class << self
      def default_api_host
        ENV['TUMBLR_API_HOST'] || 'api.tumblr.com'
      end
    end

    include Tumblr::Request
    include Tumblr::Blog
    include Tumblr::User
    include Tumblr::Post
    include Tumblr::Tagged
    include Tumblr::Helper
    include Tumblr::Connection

    def initialize(attrs= {})
      attrs = Tumblr.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    def api_host
      self.class.default_api_host
    end

    def credentials
      {
        :consumer_key => @consumer_key,
        :consumer_secret => @consumer_secret,
        :token => @oauth_token,
        :token_secret => @oauth_token_secret
      }
    end

  end
end
