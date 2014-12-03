module DiscourseApi
  module API
    module Posts
      def create_post(args)
        post("/posts", API.params(args)
                       .required(:topic_id, :raw))
      end

      def get_post(id, args = {})
        response = get("/posts/#{id}.json", API.params(args)
                                            .optional(:version))
        response[:body]
      end
    end
  end
end
