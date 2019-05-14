# frozen_string_literal: true
module DiscourseApi
  module API
    module Topics
      # :category OPTIONAL name of category, not ID
      # :skip_validations OPTIONAL boolean
      # :auto_track OPTIONAL boolean
      # :created_at OPTIONAL seconds since epoch.
      def create_topic(args = {})
        args = API.params(args)
          .required(:title, :raw)
          .optional(:skip_validations, :category, :auto_track, :created_at, :api_username)
        post("/posts", args.to_h)
      end

      def create_topic_action(args)
        args = API.params(args)
          .required(:id, :post_action_type_id)
        post("/post_actions", args.to_h.merge(flag_topic: true))
      end

      # timestamp is seconds past the epoch.
      def edit_topic_timestamp(topic_id, timestamp)
        put("/t/#{topic_id}/change-timestamp", timestamp: timestamp)
      end

      def latest_topics(params = {})
        response = get('/latest.json', params)
        response[:body]['topic_list']['topics']
      end

      def new_topics(params = {})
        response = get("/new.json", params)
        response[:body]['topic_list']['topics']
      end

      def rename_topic(topic_id, title)
        put("/t/#{topic_id}.json", topic_id: topic_id, title: title)
      end

      def recategorize_topic(topic_id, category_id)
        put("/t/#{topic_id}.json", topic_id: topic_id, category_id: category_id)
      end

      def change_topic_status(topic_slug, topic_id, params = {})
        params = API.params(params)
          .required(:status, :enabled)
          .optional(:api_username)
        put("/t/#{topic_slug}/#{topic_id}/status", params.to_h)
      end

      def topic(id, params = {})
        response = get("/t/#{id}.json", params)
        response[:body]
      end

      def topics_by(username, params = {})
        response = get("/topics/created-by/#{username}.json", params)
        response[:body]['topic_list']['topics']
      end

      def delete_topic(id)
        delete("/t/#{id}.json")
      end

      def topic_posts(topic_id, post_ids = [])
        url = "/t/#{topic_id}/posts.json"
        if post_ids.count > 0
          url << '?'
          post_ids.each do |id|
            url << "post_ids[]=#{id}&"
          end
        end
        response = get(url)
        response[:body]
      end
    end
  end
end
