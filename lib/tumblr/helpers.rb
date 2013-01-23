module Tumblr
  class Client
    module Helper
      
      def valid_options(valid_opts, opts)
        bad_opts = opts.select { |val| !valid_opts.include?(val) }
        if !bad_opts.empty?
          raise Exception, "Invalid options passed, Only #{valid_opts} allowed."
        end
        return true
      end

      def contains_both(opts, fparam, sparam)
        if opts.has_key?(fparam) && opts.has_key?(sparam)
          raise Exception, "You can only use one parameter, either #{fparam} or #{sparam}."
        end
      end

    end
  end
end
