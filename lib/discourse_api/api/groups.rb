module DiscourseApi
  module API
    module Groups
      def create_group(args)
        args = API.params(args)
                  .required(:name)
                  .default(visible: true)
                  .to_h
        post("/admin/groups", args)
      end

      def groups
        response = get("/admin/groups.json")
        response.body
      end

      def group_add(group_id, users)
        users.keys.each do |key|
          # Accept arrays and convert to comma-delimited string.
          if users[key].respond_to? :join
            users[key] = users[key].join(",")
          end

          # Accept non-plural user_id or username, but send pluralized version in the request.
          if key.to_s[-1] != 's'
            users["#{key}s"] = users[key]
            users.delete(key)
          end
        end

        put("/admin/groups/#{group_id}/members.json", users)
      end

      def group_remove(group_id, user)
        delete("/admin/groups/#{group_id}/members.json", user)
      end

      def delete_group(group_id)
        delete("/admin/groups/#{group_id}.json")
      end

      def group_members(group_id)
        all_members = []
        page = 0
        per_page = 100
        while page < 10_000
          q = "?limit=#{per_page}&offset=#{page * per_page}"
          response = get("/groups/#{group_id}/members.json#{q}")
          members = response.body['members']
          all_members += members
          break if members.count < per_page
          page += 1
        end
        all_members
      end
    end
  end
end
