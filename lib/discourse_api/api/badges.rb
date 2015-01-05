module DiscourseApi
  module API
    module Badges
      def badges
        response = get("/admin/badges.json")
        response.body
      end
    end
  end
end
