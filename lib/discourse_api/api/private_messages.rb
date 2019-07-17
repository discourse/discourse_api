# frozen_string_literal: true
module DiscourseApi
  module API
    module PrivateMessages

      # :target_usernames REQUIRED comma separated list of usernames
      # :category OPTIONAL name of category, not ID
      # :created_at OPTIONAL seconds since epoch.
      def create_private_message(args = {})
        args[:archetype] = 'private_message'
        args = API.params(args)
          .required(:title, :raw, :target_usernames, :archetype)
          .optional(:category, :created_at, :api_username)
        post("/posts", args.to_h)
      end

      def private_messages(username, *args)
        response = get("topics/private-messages/#{username}.json", args)
        response[:body]['topic_list']['topics']
      end

      def sent_private_messages(username, *args)
        response = get("topics/private-messages-sent/#{username}.json", args)
        response[:body]['topic_list']['topics']
      end
    end
  end
end
