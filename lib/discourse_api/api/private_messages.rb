module DiscourseApi
  module API
    module PrivateMessages
      def private_messages(username)
        response = get("topics/private-messages/#{username}.json", api_key: api_key, api_username: api_username)
        response[:body]
      end
    end
  end
end
