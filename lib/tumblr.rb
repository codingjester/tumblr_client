require "tumblr/client"
require "tumblr/config"

module Tumblr
  extend Config
  class << self
    def new(options={})
      Tumblr::Client.new(options)
    end
  end
end
