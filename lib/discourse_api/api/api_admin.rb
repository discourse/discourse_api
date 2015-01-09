module DiscourseApi
  module API
    module ApiAdmin
      def api
        response = get("/admin/api.json")
        response.body
      end
    end
  end
end
