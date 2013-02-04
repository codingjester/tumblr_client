module Tumblr
  module Post

    STANDARD_POST_OPTIONS = [:state, :tags, :tweet, :date, :markdown, :slug, :format]

    def edit(blog_name, options = {})
      post("v2/blog/#{blog_name}/post/edit", options)
    end

    def reblog(blog_name, options = {})
      post("v2/blog/#{blog_name}/post/reblog", options)
    end

    def delete(blog_name, id)
      post("v2/blog/#{blog_name}/post/delete", :id => id)
    end

    def photo(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:caption, :link, :data, :data_raw, :source, :photoset_layout]
      validate_options(valid_opts, options)
      validate_no_collision options, [:data, :source]

      # Allow source to be passed as an Array
      if options.has_key?(:source) && options[:source].kind_of?(Array)
        options[:source].each.with_index do |src, idx|
          options["source[#{idx}]"] = src
        end
        options.delete(:source)
      end

      options[:type] = 'photo'
      extract_data!(options)
      post("v2/blog/#{blog_name}/post", options)
    end

    def quote(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:quote, :source]
      validate_options(valid_opts, options)

      options[:type] = 'quote'
      post("v2/blog/#{blog_name}/post", options)
    end

    def text(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:title, :body]
      validate_options(valid_opts, options)

      options[:type] = 'text'
      post("v2/blog/#{blog_name}/post", options)
    end

    def link(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:title, :url, :description]
      validate_options(valid_opts, options)

      options[:type] = 'link'
      post("v2/blog/#{blog_name}/post", options)
    end

    def chat(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:title, :conversation]
      validate_options(valid_opts, options)

      options[:type] = 'chat'
      post("v2/blog/#{blog_name}/post", options)
    end

    def audio(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:data, :data_raw, :caption, :external_url]
      validate_options(valid_opts, options)
      validate_no_collision options, [:data, :external_url]

      options[:type] = 'audio'
      extract_data!(options)
      post("v2/blog/#{blog_name}/post", options)
    end

    def video(blog_name, options = {})
      valid_opts = STANDARD_POST_OPTIONS + [:data, :data_raw, :embed, :caption]
      validate_options(valid_opts, options)
      validate_no_collision options, [:data, :embed]

      options[:type] = 'video'
      extract_data!(options)
      post("v2/blog/#{blog_name}/post", options)
    end

    private

    # Look for the various ways that data can be passed, and normalize
    # the result in this hash
    def extract_data!(options)
      validate_no_collision options, [:data, :data_raw]
      if options.has_key?(:data)
        data = options.delete :data
        data = [data] unless Array === data
        data.each.with_index do |filepath, idx|
          options["data[#{idx}]"] = File.open(filepath, 'rb').read
        end
      elsif options.has_key?(:data_raw)
        data_raw = options.delete :data_raw
        data_raw = [data_raw] unless Array === data_raw
        data_raw.each.with_index do |dr, idx|
          options["data[#{idx}]"] = dr
        end
      end
    end

  end
end
