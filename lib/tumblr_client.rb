require "tumblr_client/client"
require "tumblr_client/config"

module Tumblr
  extend Config
  class << self
    def new(options={})
      Tumblr::Client.new(options)
    end
  end
end
