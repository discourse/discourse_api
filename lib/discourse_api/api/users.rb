module DiscourseApi
  module API
    module Users
      def activate(id)
        put("/admin/users/#{id}/activate")
      end

      def user(username, params={})
        response = get("/users/#{username}.json", params)
        response[:body]['user']
      end

      def user_sso(user_id)
        response = get("/admin/users/#{user_id}.json")
        response[:body]['single_sign_on_record']
      end

      def update_avatar(args)
        args = API.params(args)
                  .required(:username)
                  .optional(:file, :url)
                  .default(type: 'avatar', synchronous: true)
                  .to_h
        upload_response = post("/uploads", args)
        put("/users/#{args[:username]}/preferences/avatar/pick", { upload_id: upload_response['id'] })
      end

      def update_email(username, email)
        put("/users/#{username}/preferences/email", { email: email, api_key: api_key })
      end

      def update_user(username, params={})
        put("/users/#{username}", params)
      end

      def update_username(username, new_username)
        put("/users/#{username}/preferences/username", { new_username: new_username, api_key: api_key })
      end

      def update_trust_level(args)
        args = API.params(args)
                  .required(:user_id, :level)
                  .to_h
        response = put("/admin/users/#{args[:user_id]}/trust_level", args)
        response[:body]
      end

      def create_user(args)
        args = API.params(args)
                  .required(:name, :email, :password, :username)
                  .optional(:active, :staged, :user_fields)
                  .to_h
        post("/users", args)
      end

      def log_out(id)
        post("/admin/users/#{id}/log_out")
      end

      def invite_admin(args={})
        post("/admin/users/invite_admin", args)
      end

      def list_users(type, params = {})
        response = get("admin/users/list/#{type}.json", params)
        response[:body]
      end

      def grant_admin(user_id)
        response = put("admin/users/#{user_id}/grant_admin")
        response[:body]
      end

      def revoke_admin(user_id)
        response = put("admin/users/#{user_id}/revoke_admin")
        response[:body]
      end

      def by_external_id(external_id)
        response = get("/users/by-external/#{external_id}")
        response[:body]['user']
      end

      def suspend(user_id, suspend_until, reason)
        put("/admin/users/#{user_id}/suspend", {suspend_until: suspend_until, reason: reason})
      end

      def unsuspend(user_id)
        put("/admin/users/#{user_id}/unsuspend")
      end

      def delete_user(user_id, delete_posts = false)
        delete("/admin/users/#{user_id}.json?delete_posts=#{delete_posts}")
      end

      def check_username(username)
        response = get("/users/check_username.json?username=#{CGI.escape(username)}")
        response[:body]
      end
    end
  end
end
