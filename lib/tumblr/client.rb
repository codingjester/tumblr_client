require 'tumblr/blog'
require 'tumblr/user'
require 'tumblr/request'
require 'tumblr/connection'
require 'tumblr/post'
require 'tumblr/helpers'

module Tumblr
  class Client
    include Tumblr::Request
    include Tumblr::Client::Blog
    include Tumblr::Client::User
    include Tumblr::Client::Post
    include Tumblr::Client::Helper
    include Tumblr::Connection
    
    def initialize(attrs= {})
      attrs = Tumblr.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end
  end
end
