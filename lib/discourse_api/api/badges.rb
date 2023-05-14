# frozen_string_literal: true
module DiscourseApi
  module API
    module Badges
      def badges
        response = get("/admin/badges.json")
        response.body
      end

      def user_badges(username)
        response = get("/user-badges/#{username}.json")
        response.body["badges"]
      end

      def grant_user_badge(params = {})
        post("/user_badges", params)
      end

      def create_badge(params = {})
        args =
          API
            .params(params)
            .required(:name, :badge_type_id)
            .optional(
              :description,
              :allow_title,
              :multiple_grant,
              :icon,
              :listable,
              :target_posts,
              :query,
              :enabled,
              :auto_revoke,
              :badge_grouping_id,
              :trigger,
              :show_posts,
              :image,
              :long_description,
            )
        post("/admin/badges.json", args)
      end
    end
  end
end
