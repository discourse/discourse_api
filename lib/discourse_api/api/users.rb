module DiscourseApi
  module API
    module Users
      def toggle_avatar(username, use_uploaded_avatar)
        put("/users/#{username}/preferences/avatar/toggle", { use_uploaded_avatar: use_uploaded_avatar })
      end

      def activate(id)
        put "/admin/users/#{id}/activate", api_key: api_key, api_username: api_username
      end

      def user(username, *args)
        response = get("/users/#{username}.json", args)
        response[:body]['user']
      end

      def update_avatar(username, file)
        put("/users/#{username}/preferences/avatar", { api_username: username, file: file, api_key: api_key })
      end

      def update_email(username, email)
        put("/users/#{username}/preferences/email", { api_username: username, email: email, api_key: api_key}, csrf_token: true)
      end

      def update_user(username, *args)
        put("/users/#{username}", args)
      end

      def update_username(username, new_username)
        put("/users/#{username}/preferences/username", { api_username: username, new_username: new_username, api_key: api_key })
      end

      # Create a user
      def create_user(*args)
        # First retrieve the honeypot values
        response = get("/users/hp.json")
        args.first[:password_confirmation] = response[:body]['value']
        args.first[:challenge] = response[:body]['challenge'].reverse

        # POST the args
        post("/users", args)
      end
    end
  end
end