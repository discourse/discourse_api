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

      def update_avatar(args)
        params = API.params(args)
                    .required(:username, :file)
                    .default(image_type: 'avatar')
                    .to_h
        upload_response = post("/users/#{args[:username]}/preferences/user_image", params)
        put("/users/#{args[:username]}/preferences/avatar/pick", { upload_id: upload_response['upload_id'] })
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

      def create_user(args={})
        # First retrieve the honeypot values
        # TODO, none of this should be needed via API
        response = get("/users/hp.json")
        args[:password_confirmation] = response[:body]['value']
        args[:challenge] = response[:body]['challenge'].reverse

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
