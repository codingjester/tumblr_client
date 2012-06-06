require 'tumblr_client/blog'
require 'tumblr_client/config'
require 'tumblr_client/user'
require 'tumblr_client/request'
require 'tumblr_client/connection'
require 'tumblr_client/post'
require 'tumblr_client/helpers'

module Tumblr
  class Client
    include Tumblr::Request
    include Tumblr::Client::Blog
    include Tumblr::Client::User
    include Tumblr::Client::Post
    include Tumblr::Client::Helper
    include Tumblr::Connection

    attr_accessor *Config::VALID_OPTIONS_KEYS

    def initialize(attrs= {})
      attrs = Tumblr.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    def credentials
      {
        :consumer_key    => consumer_key,
        :consumer_secret => consumer_secret,
        :token           => oauth_token,
        :token_secret    => oauth_token_secret
      }
    end
  end
end
