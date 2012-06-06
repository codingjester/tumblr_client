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
    end
  end
end
