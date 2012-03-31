# Tumblr Ruby Gem

This is a ruby wrapper for the Tumblr v2 API. There should be support for all endpoints
currently available on the [Tumblr API]('http://www.tumblr.com/docs/en/api/v2').

## Installation

It hasn't been submitted to ruby gems yet so you'll have to build your gem first. 

    gem build tumblr.gemspec

Then you can just install with:

    gem install tumblr-0.5.gem

## Usage

First and foremost, this gem will *not* do a three legged oauth request for you. There are a ton of gems
that would do it better than I ever could. The [Ruby OAuth Gem](http://oauth.rubyforge.org/) is a perfect example :)

### Configuration

Configuration is actually pretty easy:

    Tumblr.configure do |config|
        config.consumer_key = "consumer_key"
        config.consumer_secret = "consumer_secret"
        config.oauth_token = "access_token"
        config.oauth_token_secret = "access_token_secret"
    end

There is an irb console packaged with the gem that should help you test any calls you want to make.
