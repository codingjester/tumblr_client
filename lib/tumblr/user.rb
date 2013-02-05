module Tumblr
  module User

    def info
      get('v2/user/info')
    end

    def dashboard(options = {})
      valid_opts = [:limit, :offset, :type, :since_id, :reblog_info, :notes_info]
      validate_options(valid_opts, options)
      get('v2/user/dashboard', options)
    end

    def likes(options = {})
      validate_options([:limit, :offset], options)
      get('v2/user/likes', options)
    end

    def following(options = {})
      validate_options([:limit, :offset], options)
      get('v2/user/following', options)
    end

    def follow(url)
      post('v2/user/follow', :url => url)
    end

    def unfollow(url)
      post('v2/user/unfollow', :url => url)
    end

    def like(id, reblog_key)
      post('v2/user/like', :id => id, :reblog_key => reblog_key)
    end

    def unlike(id, reblog_key)
      post('v2/user/unlike', :id => id, :reblog_key => reblog_key)
    end

  end
end
