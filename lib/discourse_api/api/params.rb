# frozen_string_literal: true
module DiscourseApi
  module API
    def self.params(args)
      Params.new(args)
    end

    class Params
      def initialize(args)
        raise ArgumentError.new("Required to be initialized with a Hash") unless args.is_a? Hash
        @args = args
        @required = []
        @optional = []
        @defaults = {}
      end

      def required(*keys)
        @required.concat(keys)
        @required.each do |k|
          raise ArgumentError.new("#{k} is required but not specified") unless @args.key?(k)
        end
        self
      end

      def optional(*keys)
        @optional.concat(keys)
        self
      end

      def default(args)
        args.each { |k, v| @defaults[k] = v }
        self
      end

      def to_h
        h = {}

        @required.each { |k| h[k] = @args[k] }

        @optional.each { |k| h[k] = @args[k] if @args.include?(k) }

        @defaults.each { |k, v| @args.key?(k) ? h[k] = @args[k] : h[k] = v }

        h
      end
    end
  end
end
