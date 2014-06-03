module DiscourseApi
  module API
    module Search
      # Returns search results that match the specified term.
      #
      # @param term [String] a search term
      # @param options [Hash] A customizable set of options
      # @option options [String] :type_filter Returns results of the specified type.
      # @return [Array] Return results as an array of Hashes.
      def search(term, options={})
        response = get('/search.json', options.merge(term: term))
        response[:body]
      end
    end
  end
end
