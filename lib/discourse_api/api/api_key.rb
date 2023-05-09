# frozen_string_literal: true
module DiscourseApi
  module API
    module ApiKey
      def list_api_keys
        response = get("/admin/api/keys")
        response[:body]
      end

      def create_api_key(args)
        args = API.params(args).required(:key).to_h
        post("/admin/api/keys", args)
      end

      def revoke_api_key(id)
        post("/admin/api/keys/#{id}/revoke")
      end

      def undo_revoke_api_key(id)
        post("/admin/api/keys/#{id}/undo-revoke")
      end

      def delete_api_key(id)
        delete("/admin/api/keys/#{id}")
      end
    end
  end
end
