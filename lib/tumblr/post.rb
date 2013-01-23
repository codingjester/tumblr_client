module Tumblr
  class Client
    module Post
      
      @@standard_post_options  = [:state, :tags, :tweet, :date, :markdown, :slug, :format]
      
      def edit(blog_name, options={})
        post("v2/blog/#{blog_name}/post/edit", options)  
      end

      #Don't be lazy and create a nice interface
      def reblog(blog_name, options={})
        post("v2/blog/#{blog_name}/post/reblog", options)  
      end
      
      def delete(blog_name, id)
        post("v2/blog/#{blog_name}/post/delete", {:id => id})  
      end

      def photo(blog_name, options={})
        
        contains_both(options, :source, :data)
        
        if options.has_key?(:source) && options[:source].kind_of?(Array)
          count = 0
          options[:source].each do |src|
            options["source[#{count}]"] = src
            count += 1
          end
          options.delete(:source)
        end

        if options.has_key?(:data) && options[:data].kind_of?(Array)
          count = 0
          options[:data].each do |filepath|
            options["data[#{count}]"] = File.open(filepath, 'rb').read()
            count += 1
          end
          options.delete(:data)
        else
          options[:data] = File.open(options[:data],'rb').read()
        end

        send_create("photo", blog_name, options, [:caption, :link, :data, :source, :photoset_layout])
      end

      
      def quote(blog_name, options={})
        send_create("quote", blog_name, options, [:quote, :source])
      end

      def text(blog_name, options={})
        send_create("text", blog_name, options, [:title, :body])
      end

      def link(blog_name, options={})
        send_create("link", blog_name, options, [:title, :url, :description])
      end

      def chat(blog_name, options={})
        send_create("chat", blog_name, options, [:title, :conversation])
      end

      def audio(blog_name, options={})
        contains_both(:data, :external_url)
        if(options.has_key?(:data))
          options[:data] = File.open(options[:data],'rb').read()
        end
        send_create("audio", blog_name, options, [:data, :caption, :external_url])
      end
      
      def video(blog_name, options={})
        contains_both(:data, :embed)
        if (options.has_key?(:data))
          options[:data] = File.open(options[:data],'rb').read()
        end
        send_create("video", blog_name, options, [:data, :embed, :caption])
      end
      
      private

      def send_create(type, blog_name, options={}, validators=[])
        valid_opts = @@standard_post_options + validators
        if valid_options(valid_opts, options)
          options[:type] = type
          post("v2/blog/#{blog_name}/post", options)
        end
      end

    end
  end
end
