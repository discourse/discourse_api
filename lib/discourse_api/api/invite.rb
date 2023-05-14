# frozen_string_literal: true
module DiscourseApi
  module API
    module Invite
      def invite_user(params = {})
        args =
          API
            .params(params)
            .optional(
              :email,
              :skip_email,
              :custom_message,
              :max_redemptions_allowed,
              :topic_id,
              :group_ids,
              :expires_at,
            )
            .to_h

        post("/invites", args)
      end

      # TODO: Deprecated. Remove after 20220506
      def invite_user_to_topic(params = {})
        deprecated(__method__, "invite_to_topic")
        invite_to_topic(params[:topic_id], params)
      end

      def invite_to_topic(topic_id, params = {})
        args = API.params(params).optional(:email, :user, :group_ids, :custom_message).to_h

        post("/t/#{topic_id}/invite", args)
      end

      def retrieve_invite(params = {})
        args = API.params(params).required(:email).to_h

        response = get("invites/retrieve.json", args)

        response.body
      end

      # requires this plugin => https://github.com/discourse/discourse-invite-tokens
      def disposable_tokens(params = {})
        post("/invite-token/generate", params)
      end

      def update_invite(invite_id, params = {})
        args =
          API
            .params(params)
            .optional(
              :topic_id,
              :group_ids,
              :group_names,
              :email,
              :send_email,
              :custom_message,
              :max_redemptions_allowed,
              :expires_at,
            )
            .to_h

        put("invites/#{invite_id}", args)
      end

      def destroy_all_expired_invites
        post("invites/destroy-all-expired")
      end

      def resend_all_invites
        post("invites/reinvite-all")
      end

      def resend_invite(email)
        post("invites/reinvite", { email: email })
      end

      def destroy_invite(invite_id)
        delete("/invites", { id: invite_id })
      end
    end
  end
end
