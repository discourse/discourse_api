# frozen_string_literal: true
module DiscourseApi
  module API
    module Tags
      def show_tag(tag)
        response = get("/tag/#{tag}")
        response[:body]
      end
    end
  end
end
