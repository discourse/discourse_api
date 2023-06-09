# frozen_string_literal: true
module DiscourseApi
  module API
    module Users
      def activate(id)
        put("/admin/users/#{id}/activate")
      end

      def user(username, params = {})
        response = get("/users/#{username}.json", params)
        response[:body]["user"]
      end

      def user_sso(user_id)
        response = get("/admin/users/#{user_id}.json")
        response[:body]["single_sign_on_record"]
      end

      def update_avatar(username, args)
        args =
          API.params(args).optional(:file, :url).default(type: "avatar", synchronous: true).to_h
        upload_response = post("/uploads", args)
        put("/u/#{username}/preferences/avatar/pick", upload_id: upload_response["id"])
      end

      def update_email(username, email)
        put("/u/#{username}/preferences/email", email: email)
      end

      def update_user(username, args)
        args =
          API
            .params(args)
            .optional(
              :name,
              :title,
              :bio_raw,
              :location,
              :website,
              :profile_background,
              :card_background,
              :email_messages_level,
              :mailing_list_mode,
              :homepage_id,
              :theme_ids,
              :user_fields,
            )
            .to_h
        put("/u/#{username}", args)
      end

      def update_username(username, new_username)
        put("/u/#{username}/preferences/username", new_username: new_username)
      end

      def update_trust_level(user_id, args)
        args = API.params(args).required(:level).to_h
        response = put("/admin/users/#{user_id}/trust_level", args)
        response[:body]
      end

      def create_user(args)
        args =
          API
            .params(args)
            .required(:name, :email, :password, :username)
            .optional(:active, :approved, :staged, :user_fields)
            .to_h
        post("/users", args)
      end

      def log_out(id)
        post("/admin/users/#{id}/log_out")
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

      def grant_moderation(user_id)
        response = put("admin/users/#{user_id}/grant_moderation")
        response[:body]
      end

      def revoke_moderation(user_id)
        put("admin/users/#{user_id}/revoke_moderation")
      end

      def by_external_id(external_id)
        response = get("/users/by-external/#{external_id}")
        response[:body]["user"]
      end

      def suspend(user_id, suspend_until, reason)
        put("/admin/users/#{user_id}/suspend", suspend_until: suspend_until, reason: reason)
      end

      def unsuspend(user_id)
        put("/admin/users/#{user_id}/unsuspend")
      end

      def anonymize(user_id)
        put("/admin/users/#{user_id}/anonymize")
      end

      def delete_user(user_id, delete_posts = false)
        delete("/admin/users/#{user_id}.json?delete_posts=#{delete_posts}")
      end

      def check_username(username)
        response = get("/users/check_username.json?username=#{CGI.escape(username)}")
        response[:body]
      end

      def deactivate(user_id)
        put("/admin/users/#{user_id}/deactivate")
      end
    end
  end
end
