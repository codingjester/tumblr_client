module Tumblr
  class Client
    module Tagged

      def tagged(tag, options={})
        valid_options([:before, :limit, :filter], options)

        params = { :tag => tag, :api_key => @consumer_key }
        params.merge!(options)
        get("v2/tagged", params)
      end

    end
  end
end
