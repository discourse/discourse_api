# frozen_string_literal: true
module DiscourseApi
  module API
    module Search
      # Returns search results that match the specified term.
      #
      # @param term [String] a search term
      # @param options [Hash] A customizable set of options
      # @option options [String] :type_filter Returns results of the specified type.
      # @return [Array] Return results as an array of Hashes.
      def search(term, options = {})
        raise ArgumentError.new("#{term} is required but not specified") unless term
        raise ArgumentError.new("#{term} is required but not specified") if term.empty?

        response = get("/search", options.merge(q: term))
        response[:body]
      end
    end
  end
end
