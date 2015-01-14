module DiscourseApi
  module API
    module Badges
      def badges
        response = get("/admin/badges.json")
        response.body
      end

      def user_badges(username)
        response = get("/users/#{username}/activity/badges.json")
        response.body['badges']
      end

      def grant_user_badge(params={})
        post("/user_badges", params)
      end
    end
  end
end
