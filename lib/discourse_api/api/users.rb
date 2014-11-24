module DiscourseApi
  module API
    module Users
      def activate(id)
        put "/admin/users/#{id}/activate", api_key: api_key, api_username: api_username
      end

      def user(username, *args)
        response = get("/users/#{username}.json", args)
        response[:body]['user']
      end

      def update_avatar(username, file)
        put("/users/#{username}/preferences/avatar", { file: file, api_key: api_key })
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

      # Create a user
      def create_user(args={})
        # First retrieve the honeypot values
        # TODO, none of this should be needed via API
        response = get("/users/hp.json")
        args[:password_confirmation] = response[:body]['value']
        args[:challenge] = response[:body]['challenge'].reverse

        # POST the args
        post("/users", args)
      end

      def log_out(id)
        post("/admin/users/#{id}/log_out")
      end

      def invite_admin(args={})
        post("/admin/users/invite_admin", args)
      end
    end
  end
end
