# frozen_string_literal: true
module DiscourseApi
  module API
    module SSO
      def sync_sso(params = {})
        sso_secret = params.delete(:sso_secret)
        _sso_url = params.delete(:sso_url)
        querystring = URI.encode_www_form(params)

        sso = DiscourseApi::SingleSignOn.unsigned_parse(querystring, sso_secret)

        puts sso.unsigned_payload

        post("/admin/users/sync_sso", sso.payload)
      end
    end
  end
end
