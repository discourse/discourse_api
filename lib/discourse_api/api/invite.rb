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

      def update_invite(invite_id, params = {})
        args = API.params(params)
          .optional(
            :topic_id,
            :group_ids,
            :group_names,
            :email,
            :send_email,
            :custom_message,
            :max_redemptions_allowed,
            :expires_at
          ).to_h

        put("invites/#{invite_id}", args)
      end
    end
  end
end
