module DiscourseApi
  class Error < StandardError
    attr_reader :wrapped_exception

    # Initializes a new Error object
    #
    # @param exception [Exception, String]
    # @return [DiscourseApi::Error]
    def initialize(exception=$!)
      @wrapped_exception = exception
      exception.respond_to?(:message) ? super(exception.message) : super(exception.to_s)
    end
  end
end
