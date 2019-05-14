# frozen_string_literal: true
module DiscourseApi
  module API
    module ApiKey
      def api
        response = get("/admin/api.json")
        response.body
      end

      def generate_user_api_key(user_id)
        response = post("/admin/users/#{user_id}/generate_api_key.json")
      end

      def revoke_user_api_key(user_id)
        response = delete("/admin/users/#{user_id}/revoke_api_key.json")
      end

      def generate_master_key
        response = post("/admin/api/key")
      end

      def revoke_api_key(id)
        response = delete("/admin/api/key", id: id)
      end

      def regenerate_api_key(id)
        response = put("/admin/api/key", id: id)
        response.body
      end
    end
  end
end
