# frozen_string_literal: true

module DiscourseApi
  module API
    module Polls
      def poll_vote(args)
        args = API.params(args).required(:post_id, :poll_name, :options).optional(:created_at)
        put("/polls/vote", args)
      end

      def toggle_poll_status(args)
        args =
          API
            .params(args)
            .required(:post_id, :poll_name, :status)
            .optional(:api_username)
            .optional(:raise_errors)
        put("/polls/toggle_status", args)
      end

      def poll_voters(args)
        args = API.params(args).required(:post_id, :poll_name).optional(:opts)
        response = get("/polls/voters.json", args)
        response[:body]
      end
    end
  end
end
