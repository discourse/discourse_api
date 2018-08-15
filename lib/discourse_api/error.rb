module DiscourseApi
  class DiscourseError < StandardError
    attr_reader :response

    def initialize(message, response = nil)
      super(message)
      @response = response
    end
  end

  class Error < DiscourseError
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

  class UnauthenticatedError < DiscourseError
  end

  class NotFoundError < DiscourseError
  end

  class UnprocessableEntity < DiscourseError
  end

  class TooManyRequests < DiscourseError
  end
end
