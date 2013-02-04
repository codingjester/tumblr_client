module Tumblr
  class Client
    module User

      def info
        info = get('v2/user/info')
      end

      def dashboard(options = {})
        valid_opts = [:limit, :offset, :type, :since_id, :reblog_info, :notes_info]
        valid_options(valid_opts, options)
        get('v2/user/dashboard', options)
      end

      def likes(offset = 0, limit = 20)
        likes = get('v2/user/likes', :limit => limit, :offset => offset)
      end

      def following(offset = 0, limit = 20)
        get('v2/user/following', :limit => limit, :offset => offset)
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
end
