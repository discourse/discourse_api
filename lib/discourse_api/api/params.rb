module DiscourseApi
  module API
    def self.params(args)
      Params.new(args)
    end

    class Params
      def initialize(args)
        @args = args
        @required = []
        @optional = []
        @defaults = {}
      end

      def required(*keys)
        @required.concat(keys)
        self
      end

      def optional(*keys)
        @optional.concat(keys)
        self
      end

      def default(args)
        args.each do |k,v|
          @defaults[k] = v
        end
        self
      end

      def to_h
        h = {}

        @required.each do |k|
          h[k] = @args[k]
          raise ArgumentError.new("#{k} is required but not specified") unless h[k]
        end

        h =
          if @optional.length == 0
            @args.dup
          else
            @optional.each do |k|
              h[k] = @args[k] if @args[k]
            end
            h
          end

        @defaults.each do |k,v|
          h[k] = v unless h.key?(k)
        end

        h

      end
    end

  end
end
