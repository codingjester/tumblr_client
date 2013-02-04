module Tumblr
  class Client
    module Helper

      def valid_options(valid_opts, opts)
        bad_opts = opts.select { |val| !valid_opts.include?(val) }
        if !bad_opts.empty?
          raise ArgumentError.new "Invalid options (#{bad_opts.keys.join(', ')}) passed, only #{valid_opts} allowed."
        end
        return true
      end

      def validate_no_collision(options, attributes)
        count = attributes.count { |a| options.has_key?(a) }
        if count > 1
          raise ArgumentError.new "Can only use one of: #{attributes.join(', ')} (Found #{count})"
        end
      end

    end
  end
end
