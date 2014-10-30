require 'single_sign_on'

module DiscourseApi
  module API
    module SSO
      def sync_sso(params={})
        sso = SingleSignOn.new
        sso.sso_secret = params[:sso_secret]
        sso.name = params[:name]
        sso.username = params[:username]
        sso.email = params[:email]
        sso.external_id = params[:external_id]
        post("/admin/users/sync_sso/", sso.payload)
      end
    end
  end
end
