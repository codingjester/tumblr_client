require 'faraday'
require 'time'
require 'uri'
require 'openssl'
require 'base64'

module Tumblr
  module Request
    class TumblrOAuth < Faraday::Middleware

      def call(env)
        if env[:method].to_s == 'get'
          params = Faraday::Utils.parse_query(env[:url].query) || {}
          url = "#{env[:url].scheme}://#{env[:url].host}#{env[:url].path}"
        else
          params = env[:body] || {}
          url = env[:url]
        end
        signature_params = params
        params.each do |key, value|
          signature_params = {} if value.respond_to?(:content_type)
        end
        env[:request_headers]['Authorization'] = self.oauth_gen(env[:method], url, signature_params)
        env[:request_headers]['Content-type'] = 'application/x-www-form-urlencoded'
        env[:request_headers]['Host'] = @options[:api_host]

        @app.call(env)
      end

      def initialize(app, options={})
        @app, @options = app, options
      end

      def oauth_gen(method, url, params)
         params[:oauth_consumer_key] = @options[:consumer_key]
         params[:oauth_nonce] = Base64.encode64(OpenSSL::Random.random_bytes(32)).gsub(/\W/, '')
         params[:oauth_signature_method] = 'HMAC-SHA1'
         params[:oauth_timestamp] = Time.now.to_i
         params[:oauth_token] = @options[:token]
         params[:oauth_version] = '1.0'
         params[:oauth_signature] = self.oauth_sig(method, url, params)

         header = []
         params.each do |key, value|
           if key.to_s.include?('oauth')
             header << "#{key.to_s}=#{value}"
           end
         end

         "OAuth #{header.join(", ")}"
      end

      def oauth_sig(method, url, params)
        parts = [method.upcase, URI.encode(url.to_s, /[^a-z0-9\-\.\_\~]/i)]

        #sort the parameters
        params = Hash[params.sort_by{ |key, value| key.to_s}]

        encoded = []
        params.each do |key, value|
          encoded << "#{key.to_s}=#{URI.encode(value.to_s, /[^a-z0-9\-\.\_\~]/i)}"
        end

        parts << URI.encode(encoded.join('&'), /[^a-z0-9\-\.\_\~]/i)
        signature_base = parts.join('&')
        secret = "#{@options[:consumer_secret]}&#{@options[:token_secret]}"
        Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, secret, signature_base)).chomp.gsub(/\n/, '')
      end

    end
  end
end
