module DiscourseApi
  module API
    module Backups
      def backups
        response = get("/admin/backups.json")
        response.body
      end
    end
  end
end
