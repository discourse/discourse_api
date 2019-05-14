# frozen_string_literal: true
module DiscourseApi
  module API
    module Invite
      def invite_user(params = {})
        post("/invites", params)
      end

      def invite_user_to_topic(params = {})
        post("/t/#{params[:topic_id]}/invite", params)
      end

      # requires this plugin => https://github.com/discourse/discourse-invite-tokens
      def disposable_tokens(params = {})
        post("/invite-token/generate", params)
      end
    end
  end
end
