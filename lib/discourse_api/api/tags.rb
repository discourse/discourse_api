# frozen_string_literal: true
module DiscourseApi
  module API
    module Tags
      def show_tag(tag)
        response = get("/tags/#{tag}")
        response[:body]
      end
    end
  end
end
