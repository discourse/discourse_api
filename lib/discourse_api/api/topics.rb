module DiscourseApi
  module API
    module Topics

      def invite_user_to_topic(params={})
        post("/t/#{params[:topic_id]}/invite", params)
      end

      def create_topic(params={})
        post("/posts", params)
      end

      def latest_topics(*args)
        response = get('/latest.json', args)
        response[:body]['topic_list']['topics']
      end

      def new_topics(*args)
        response = get("/new.json", args)
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
