# frozen_string_literal: true
module DiscourseApi
  module API
    module SSO
      def sync_sso(params = {})
        sso = DiscourseApi::SingleSignOn.parse_hash(params)

        post("/admin/users/sync_sso", sso.payload)
      end
    end
  end
end
