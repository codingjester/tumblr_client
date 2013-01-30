module Tumblr
  class Client
    module Tagged
      
      @@standard_options = [:before, :limit, :filter]
      
      def tagged(tag, options={})
        params = {:tag => tag, :api_key => @consumer_key}
        unless options.empty?
          params.merge!(options)
        end
        if valid_options(@@standard_options, options)
            get("v2/tagged", params)
        end
      end
    end
  end
end
