# frozen_string_literal: true
module DiscourseApi
  module API
    module Posts
      def create_post(args)
        args = API.params(args)
          .required(:topic_id, :raw)
          .optional(:created_at, :api_username)
        post("/posts", args)
      end

      def create_post_action(args)
        args = API.params(args)
          .required(:id, :post_action_type_id)
        post("/post_actions", args.to_h.merge(flag_topic: false))
      end

      def get_post(id, args = {})
        args = API.params(args)
          .optional(:version)
        response = get("/posts/#{id}.json", args)
        response[:body]
      end

      def posts(args = {})
        args = API.params(args).default(before: 0)
        response = get("/posts.json", args)
        response[:body]
      end

      def wikify_post(id)
        put("/posts/#{id}/wiki", wiki: true)
      end

      def edit_post(id, raw)
        put("/posts/#{id}", post: { raw: raw })
      end

      def delete_post(id)
        delete("/posts/#{id}.json")
      end

      def destroy_post_action(post_id, post_action_type_id)
        delete("/post_actions/#{post_id}.json", post_action_type_id: post_action_type_id)
      end

      def post_action_users(post_id, post_action_type_id)
        response = get("/post_action_users.json", id: post_id, post_action_type_id: post_action_type_id)
        response[:body]
      end
    end
  end
end
