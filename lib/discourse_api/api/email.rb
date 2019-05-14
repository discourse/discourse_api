# frozen_string_literal: true
module DiscourseApi
  module API
    module Email
      def email_settings
        response = get("/admin/email.json")
        response.body
      end

      def list_email(filter)
        response = get("/admin/email/#{filter}.json")
        response.body
      end
    end
  end
end
