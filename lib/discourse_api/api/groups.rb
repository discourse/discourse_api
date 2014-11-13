module DiscourseApi
  module API
    module Groups
      def create_group(name:, visible: false)
        post("/admin/groups", group: {name: name, visible: visible.to_s})
      end

      def groups
        response = get("/admin/groups")
        response.body
      end
    end
  end
end
