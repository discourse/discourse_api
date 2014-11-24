module DiscourseApi
  module API
    module Groups
      def create_group(args)

        post("/admin/groups", group: API.params(args)
                                         .required(:name)
                                         .default(visible: true)
                                         .to_h
        )
      end

      def groups
        response = get("/admin/groups.json")
        response.body
      end

      def group_add(group_id, *usernames)
        patch("/admin/groups/#{group_id}", changes: {add: usernames})
      end

      def group_remove(group_id, *usernames)
        patch("/admin/groups/#{group_id}", changes: {delete: usernames})
      end
    end
  end
end
