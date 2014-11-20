module DiscourseApi
  module API
    module Groups
      def create_group(name:, visible: true)
        post("/admin/groups", group: {name: name, visible: visible.to_s})
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
