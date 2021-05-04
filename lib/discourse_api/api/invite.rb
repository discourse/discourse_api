# frozen_string_literal: true
module DiscourseApi
  module API
    module Invite
      def invite_user(params = {})
        args = API.params(params)
          .optional(
            :email,
            :skip_email,
            :custom_message,
            :max_redemptions_allowed,
            :topic_id,
            :group_ids,
            :expires_at
          ).to_h

        post("/invites", args)
      end

      def invite_user_to_topic(topic_id, params = {})
        args = API.params(params)
          .optional(
            :email,
            :user,
            :group_ids,
            :custom_message
          ).to_h

        post("/t/#{topic_id}/invite", args)
      end

      # requires this plugin => https://github.com/discourse/discourse-invite-tokens
      def disposable_tokens(params = {})
        post("/invite-token/generate", params)
      end
    end
  end
end
