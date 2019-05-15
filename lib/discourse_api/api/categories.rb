# frozen_string_literal: true
module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      # :permissions is a hash with the group name and permission_type which is
      # an integer 1 = Full 2 = Create Post 3 = Read Only
      def create_category(args = {})
        args = API.params(args)
          .required(:name, :color, :text_color)
          .optional(:description, :permissions, :custom_fields)
          .default(parent_category_id: nil)
        response = post("/categories", args)
        response['category']
      end

      def update_category(args = {})
        category_id = args[:id]
        args = API.params(args)
          .required(:id, :name, :color, :text_color)
          .optional(:slug, :permissions, :auto_close_hours, :auto_close_based_on_last_post, :position, :email_in,
                             :email_in_allow_strangers, :logo_url, :background_url, :allow_badges, :topic_template, :custom_fields)
          .default(parent_category_id: nil)
        response = put("/categories/#{category_id}", args)
        response['body']['category'] if response['body']
      end

      def categories(params = {})
        response = get('/categories.json', params)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(args = {})
        params = API.params(args)
          .required(:category_slug)
          .optional(:page).to_h
        url = "/c/#{params[:category_slug]}/l/latest.json"
        if params.include?(:page)
          url = "#{url}?page=#{params[:page]}"
        end
        response = get(url)
        if response[:body]['errors']
          response[:body]['errors']
        else
          response[:body]['topic_list']['topics']
        end
      end

      def category_top_topics(category_slug)
        response = get("/c/#{category_slug}/l/top.json")
        if response[:body]['errors']
          response[:body]['errors']
        else
          response[:body]['topic_list']['topics']
        end
      end

      def category_new_topics(category_slug)
        response = get("/c/#{category_slug}/l/new.json")
        response[:body]['topic_list']['topics']
      end

      def category(id)
        response = get("/c/#{id}/show")
        response[:body]['category']
      end

      def category_set_user_notification(args = {})
        category_id = args[:id]
        args = API.params(args)
          .required(:notification_level)
        post("/category/#{category_id}/notifications", args)
      end
    end
  end
end
