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
        self
      end

      def optional(*keys)
        @optional.concat(keys)
        self
      end

      def default(args)
        args.each do |k, v|
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

        @optional.each do |k|
          h[k] = @args[k] if @args.include?(k)
        end

        @defaults.each do |k, v|
          @args.key?(k) ? h[k] = @args[k] : h[k] = v
        end

        h

      end
    end

  end
end
