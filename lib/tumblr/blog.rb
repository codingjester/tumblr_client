module Tumblr
  module Blog

    # Gets the info about the blog
    def blog_info(blog_name)
      get(blog_path(blog_name, 'info'), :api_key => @consumer_key)
    end

    # Gets the avatar URL of specified size
    def avatar(blog_name, size = nil)
      url = blog_path(blog_name, 'avatar')
      url = "#{url}/#{size}" if size
      get_redirect_url(url)
    end

    # Gets the list of followers for the blog
    def followers(blog_name, options = {})
      validate_options([:limit, :offset], options)
      get(blog_path(blog_name, 'followers'), options)
    end

    # Gets the list of likes for the blog
    def blog_likes(blog_name, options = {})
      validate_options([:limit, :offset], options)
      url = blog_path(blog_name, 'likes')

      params = { :api_key => @consumer_key }
      params.merge! options
      get(url, params)
    end

    def posts(blog_name, options = {})
      url = blog_path(blog_name, 'posts')
      if options.has_key?(:type)
        url = "#{url}/#{options[:type]}"
      end

      params = { :api_key => @consumer_key }
      params.merge! options
      get(url, params)
    end

    def queue(blog_name, options = {})
      validate_options([:limit, :offset], options)
      get(blog_path(blog_name, 'posts/queue'), options)
    end

    def draft(blog_name, options = {})
      validate_options([:limit, :offset], options)
      get(blog_path(blog_name, 'posts/draft'), options)
    end

    def submissions(blog_name, options = {})
      validate_options([:limit, :offset], options)
      get(blog_path(blog_name, 'posts/submission'), options)
    end

  end
end
