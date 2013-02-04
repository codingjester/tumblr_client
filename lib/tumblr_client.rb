require 'tumblr/client'
require 'tumblr/config'

module Tumblr

  autoload :VERSION, File.join(File.dirname(__FILE__), 'tumblr/version')

  extend Config

  class << self
    def new(options={})
      Tumblr::Client.new(options)
    end
  end

end
