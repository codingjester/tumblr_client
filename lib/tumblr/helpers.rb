module Tumblr
  module Helper

    def validate_options(valid_opts, opts)
      bad_opts = opts.select { |val| !valid_opts.include?(val) }
      if bad_opts.any?
        raise ArgumentError.new "Invalid options (#{bad_opts.keys.join(', ')}) passed, only #{valid_opts} allowed."
      end
    end

    def validate_no_collision(options, attributes)
      count = attributes.count { |attr| options.has_key?(attr) }
      if count > 1
        raise ArgumentError.new "Can only use one of: #{attributes.join(', ')} (Found #{count})"
      end
    end

  end
end
