module DiscourseApi
  module API
    module Users
      def activate(id)
        put "/admin/users/#{id}/activate", api_key: api_key, api_username: api_username
      end

      def user(username, params={})
        response = get("/users/#{username}.json", params)
        response[:body]['user']
      end

      def user_sso(username)
        response = get("/admin/users/#{username.downcase}")
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
                  .optional(:active)
                  .to_h
        post("/users", args)
      end

      def log_out(id)
        post("/admin/users/#{id}/log_out")
      end

      def invite_admin(args={})
        post("/admin/users/invite_admin", args)
      end

      def list_users(type)
        response = get("admin/users/list/#{type}.json")
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

      def all_users
        result = []

        5.times do |i|
          result += group_members("trust_level_#{i}")
        end

        result.uniq! { |u| u['id'] }.freeze
      end
    end
  end
end
