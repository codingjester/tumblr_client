module Tumblr
  class Client
    module User
      def info
        info = post("v2/user/info")
      end

      def dashboard(options={})
        valid_opts = [:limit, :offset, :type, :since_id, :reblog_info, :notes_info]
        if valid_options(valid_opts, options)
          get("v2/user/dashboard", options)
        end
      end

      def likes(offset=0, limit=20)
        likes = get("v2/user/likes", {:limit => limit, :offset => offset})
      end

      def following(offset=0, limit=20)
        following = get("v2/user/following", {:limit => limit, :offset => offset})
      end

      def follow(url)
        follow = post("v2/user/follow", {:url => url})
      end
    
      def unfollow(url)
        follow = post("v2/user/unfollow", {:url => url})
      end

      def like(id, reblog_key)
        like = post("v2/user/like", {:id => id, :reblog_key => reblog_key})
      end

      def unlike(id, reblog_key)
        unlike = post("v2/user/unlike", {:id => id, :reblog_key => reblog_key})
      end 
    end
  end
end
