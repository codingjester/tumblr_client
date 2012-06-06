# RIPPED: https://github.com/jnunemaker/twitter/blob/591cbf1be86707584de0548365cc71c795683b2d/lib/twitter/config.rb

module Tumblr
  module Config
    DEFAULT_ADAPTER            = :net_http
    DEFAULT_CONSUMER_KEY       = nil
    DEFAULT_CONSUMER_SECRET    = nil
    DEFAULT_OAUTH_TOKEN        = nil
    DEFAULT_OAUTH_TOKEN_SECRET = nil

    VALID_OPTIONS_KEYS = [
      :adapter,
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
      self
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each{ |k| options[k] = send(k) }
      options
    end

    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      self
    end
  end
end
