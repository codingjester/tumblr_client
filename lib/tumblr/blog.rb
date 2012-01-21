module Tumblr
  class Client
    module Blog
      #
      #Gets the info about the blog
      #
      def blog_info(blog_name)
        info = get("v2/blog/#{blog_name}/info", {:api_key => Tumblr::consumer_key})
      end
    
      #
      #Gets the avatar of specified size
      #Defaults to 64
      #
      def avatar(blog_name, size=64)
        avatar = get("v2/blog/#{blog_name}/avatar", {:size => size})
      end
    
      #
      # Gets the list of followers for the blog
      #
      def followers(blog_name, options={})
        followers = get("v2/blog/#{blog_name}/followers", options)
      end

      def posts(blog_name, type=false, options={})
        url = "v2/blog/#{blog_name}/posts"
        
        if type
          url = "#{url}/#{type}"
        end
        
        params = {:api_key => Tumblr::consumer_key}
        unless options.empty?
          params.merge!(options)
        end
        posts = get(url, params)
      end

      def queue(blog_name)
        queue = get("v2/blog/#{blog_name}/posts/queue", {})
      end
      
      def draft(blog_name)
        queue = get("v2/blog/#{blog_name}/posts/draft", {})
      end
        
      def submissions(blog_name)
        submissions = get("v2/blog/#{blog_name}/posts/submission", {})
      end

    end
  end
end
