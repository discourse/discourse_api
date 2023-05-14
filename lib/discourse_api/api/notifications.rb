# frozen_string_literal: true
module DiscourseApi
  module API
    module Notifications
      def notifications(params = {})
        params = API.params(params).optional(:username, :recent, :limit, :offset, :filter)

        response = get("/notifications.json", params)
        response[:body]
      end
    end
  end
end
