module Tumblr
  class Client
    module User
      def info
        info = post("v2/user/info")
      end

      def dashboard
        dash = get("v2/user/dashboard")
      end

      def likes
        likes = get("v2/user/likes")
      end

      def following
        following = get("v2/user/following")
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
