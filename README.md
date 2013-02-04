# Tumblr Ruby Gem

This is a ruby wrapper for the Tumblr v2 API. There should be support for all endpoints
currently available on the [Tumblr API](http://www.tumblr.com/docs/en/api/v2).

## Installation

    gem install tumblr_client

## Usage

First and foremost, this gem will *not* do a three legged oauth request for you. It is just a wrapper to help make
your life easier when using the v2 api. If you need to do the full oauth workflow, then please check out the 
[Ruby OAuth Gem](http://oauth.rubyforge.org/).

### Configuration

Configuration for the gem is actually pretty easy:

    Tumblr.configure do |config|
        config.consumer_key = "consumer_key"
        config.consumer_secret = "consumer_secret"
        config.oauth_token = "access_token"
        config.oauth_token_secret = "access_token_secret"
    end

Once you have your configuration squared away it's time to make some requests!

    >> client = Tumblr.new

That's it! You now have a client that can make any request to the Tumblr API.

### Some quick examples

Getting user information:
    
    >> client.info

Getting a specific blog's posts and type:
    
    #Grabbing a specific blogs posts
    >> client.posts("codingjester.tumblr.com")
    
    #Grabbing only the last 10 photos off the blog 
    >> client.posts("codingjester.tumblr.com", :type => "photo", :limit => 10)


Posting some photos to Tumblr:

    #Uploads a great photoset
    >> client.photo("codingjester.tumblr.com", {:data => ['/path/to/pic.jpg', '/path/to/pic.jpg']}) 

### The irb Console

Finally, there is an irb console packaged with the gem that should help you test any calls you want to make.
The magic here is that you have a ```.tumblr``` file in your home directory. Inside this file it's just a basic
YAML layout with four lines:

    consumer_key: "your_consumer_key"
    consumer_secret: "your_consumer_secret"
    oauth_token: "your_access_token"
    oauth_token_secret: "your_access_token_secret"

From there, you should be able to run any of the above commands, with no problem! Just fire off the command ```tumblr``
from the terminal and you should be dropped into a console.


### Contributions and Pull Requests

No request is too small and I encourage everyone to get involved. As you can see, we're sorely lacking in tests! So
please if you would like to contribute, let me know and throw me a pull request!


### Requirements

* Ruby >= 1.9.2
