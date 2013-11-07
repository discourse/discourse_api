module DiscourseApi
  module API
    module Topics
      def hot_topics(*args)
        response = get('/hot.json', args)
        response[:body]['topic_list']['topics']
      end

      def invite_user_to_topic(user_email, topic_id)
        params = { email: user_email, topic_id: topic_id }
        post "/t/#{topic_id}/invite.json", params
      end

      def latest_topics(*args)
        response = get('/latest.json', args)
        response[:body]['topic_list']['topics']
      end

      def topic(id, *args)
        response = get("/t/#{id}.json", args)
        response[:body]
      end

      def topics_by(username, *args)
        response = get("/topics/created-by/#{username}.json", args)
        response[:body]['topic_list']['topics']
      end
    end
  end
end