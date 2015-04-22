module DiscourseApi
  module API
    module SSO
      def sync_sso(params={})
        sso = DiscourseApi::SingleSignOn.new
        sso.sso_secret = params[:sso_secret]
        sso.name = params[:name]
        sso.username = params[:username]
        sso.email = params[:email]
        sso.external_id = params[:external_id]
        sso.suppress_welcome_message = params[:suppress_welcome_message] === true
        sso.avatar_url = params[:avatar_url]
        sso.avatar_force_update = params[:avatar_force_update] === true
        post("/admin/users/sync_sso/", sso.payload)
      end
    end
  end
end
