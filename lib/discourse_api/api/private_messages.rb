module DiscourseApi
  module API
    module PrivateMessages
      def private_messages(username, *args)
        response = get("topics/private-messages/#{username}.json", args)
        response[:body]['topic_list']['topics']
      end
    end
  end
end
