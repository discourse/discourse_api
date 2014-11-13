module DiscourseApi
  module API
    module Posts
      def create_post(topic_id:, raw:)
        post("/posts", topic_id: topic_id, raw: raw)
      end
    end
  end
end
