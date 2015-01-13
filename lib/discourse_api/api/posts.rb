module DiscourseApi
  module API
    module Posts
      def create_post(args)
        args = API.params(args)
                  .required(:topic_id, :raw)
        post("/posts", args)
      end

      def get_post(id, args = {})
        args = API.params(args)
                  .optional(:version)
        response = get("/posts/#{id}.json", args)
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
