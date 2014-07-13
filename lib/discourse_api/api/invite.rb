module DiscourseApi
  module API
    module Invite
      def invite_user_to_topic(params={})
        post("/t/#{params[:topic_id]}/invite", params)
      end

      def disposable_tokens(params={})
        post("/invites/disposable", params)
      end
    end
  end
end
