module DiscourseApi
  module API
    module Notifications
      def notifications
        response = get('/notifications.json')
        response[:body]
      end

      def set_group_user_note_lev(group, user_id, notification_level)
        response = post("/groups/#{group}/notifications?user_id=#{user_id}&notification_level=#{notification_level}")
        response
      end
    end
  end
end