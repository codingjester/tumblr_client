module Tumblr
  module Tagged

    def tagged(tag, options={})
      validate_options([:before, :limit, :filter], options)

      params = { :tag => tag, :api_key => @consumer_key }
      params.merge!(options)
      get("v2/tagged", params)
    end

  end
end
