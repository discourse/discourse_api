# frozen_string_literal: true
module DiscourseApi
  module API
    module Groups
      def create_group(args)
        args =
          API
            .params(args)
            .required(:name)
            .default(visibility_level: 0)
            .optional(
              :mentionable_level,
              :messageable_level,
              :automatic_membership_email_domains,
              :automatic_membership_retroactive,
              :title,
              :primary_group,
              :grant_trust_level,
              :incoming_email,
              :flair_url,
              :flair_bg_color,
              :flair_color,
              :bio_raw,
              :members_visibility_level,
              :public_admission,
              :public_exit,
              :allow_membership_requests,
              :full_name,
              :default_notification_level,
              :usernames,
              :owner_usernames,
              :membership_request_template,
            )
            .to_h
        post("/admin/groups", group: args)
      end

      def update_group(group_id, args)
        args =
          API
            .params(args)
            .default(visibility_level: 0)
            .optional(
              :mentionable_level,
              :messageable_level,
              :name,
              :automatic_membership_email_domains,
              :title,
              :primary_group,
              :grant_trust_level,
              :incoming_email,
              :flair_url,
              :flair_bg_color,
              :flair_color,
              :bio_raw,
              :visibility_level,
              :public_admission,
              :public_exit,
              :allow_membership_requests,
              :full_name,
              :default_notification_level,
              :membership_request_template,
            )
            .to_h
        put("/groups/#{group_id}", group: args)
      end

      def group_add_owners(group_id, args)
        args = API.params(args).required(:usernames).to_h
        put("/admin/groups/#{group_id}/owners.json", group: args)
      end

      def group_remove_owners(group_id, args)
        args = API.params(args).required(:usernames).to_h
        delete("/admin/groups/#{group_id}/owners.json", group: args)
      end

      def groups(args = {})
        params = API.params(args).optional(:page).to_h

        url = "/groups.json"
        url += "?page=#{params[:page]}" if params.include?(:page)
        response = get(url)
        response.body
      end

      def group(group_name)
        response = get("/groups/#{group_name}.json")
        response.body
      end

      def group_add(group_id, users)
        users.keys.each do |key|
          # Accept arrays and convert to comma-delimited string.
          users[key] = users[key].join(",") if users[key].respond_to? :join

          # Accept non-plural user_id or username, but send pluralized version in the request.
          if key.to_s[-1] != "s"
            users["#{key}s"] = users[key]
            users.delete(key)
          end
        end

        put("/admin/groups/#{group_id}/members.json", users)
      end

      def group_remove(group_id, users)
        users.keys.each do |key|
          # Accept arrays and convert to comma-delimited string.
          users[key] = users[key].join(",") if users[key].respond_to? :join

          # Accept non-plural user_id or username, but send pluralized version in the request.
          if key.to_s[-1] != "s"
            users["#{key}s"] = users[key]
            users.delete(key)
          end
        end

        delete("/admin/groups/#{group_id}/members.json", users)
      end

      def delete_group(group_id)
        delete("/admin/groups/#{group_id}.json")
      end

      def group_members(group_name, params = {})
        options = params
        params = API.params(params).optional(:offset, :limit).default(offset: 0, limit: 100).to_h
        response = get("/groups/#{group_name}/members.json", params)

        if options[:all] == true
          response.body
        else
          response.body["members"]
        end
      end

      def group_set_user_notification_level(group, user_id, notification_level)
        post(
          "/groups/#{group}/notifications?user_id=#{user_id}&notification_level=#{notification_level}",
        )
      end
    end
  end
end
