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

      def wikify_post(id)
        put("/posts/#{id}/wiki", wiki: true)
      end

      def edit_post(id, raw)
        put("/posts/#{id}", post: {raw: raw})
      end
    end
  end
end
