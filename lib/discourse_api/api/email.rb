module DiscourseApi
  module API
    module Email
      def email_settings
        response = get("/admin/email.json")
        response.body
      end
    end
  end
end
