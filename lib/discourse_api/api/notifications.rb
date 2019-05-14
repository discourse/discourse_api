# frozen_string_literal: true
module DiscourseApi
  module API
    module Notifications
      def notifications
        response = get('/notifications.json')
        response[:body]
      end
    end
  end
end
