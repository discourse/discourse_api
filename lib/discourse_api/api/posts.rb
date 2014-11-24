module DiscourseApi
  module API
    module Posts
      def create_post(args)
        post("/posts", API.params(args)
                          .required(:topic_id, :raw))
      end
    end
  end
end
