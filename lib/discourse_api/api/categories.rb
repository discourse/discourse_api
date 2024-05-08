# frozen_string_literal: true
module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      # :permissions is a hash with the group name and permission_type which is
      # an integer 1 = Full 2 = Create Post 3 = Read Only
      def create_category(args = {})
        params = common_category_params(args)
        response = post("/categories", params.to_h)
        response["category"]
      end

      def update_category(args = {})
        category_id = args[:id]
        params = common_category_params(args, include_id: true)
        response = put("/categories/#{category_id}", params.to_h)
        response["body"]["category"] if response["body"]
      end

      def reorder_categories(args = {})
        params = API.params(args).required(:mapping)
        post("/categories/reorder", params)
      end

      def delete_category(id)
        response = delete("/categories/#{id}")
        response[:body]["success"]
      end

      def categories(params = {})
        categories_full(params)["category_list"]["categories"]
      end

      def categories_full(params = {})
        response = get("/categories.json", params)
        response[:body]
      end

      def category_latest_topics(args = {})
        response = category_latest_topics_full(args)
        if response["errors"]
          response["errors"]
        else
          response["topic_list"]["topics"]
        end
      end

      def category_latest_topics_full(args = {})
        params = API.params(args).required(:category_slug).optional(:page).to_h
        url = "/c/#{params[:category_slug]}/l/latest.json"
        url = "#{url}?page=#{params[:page]}" if params.include?(:page)
        response = get(url)
        response[:body]
      end

      def category_top_topics(category_slug)
        response = category_top_topics_full(category_slug)
        if response["errors"]
          response["errors"]
        else
          response["topic_list"]["topics"]
        end
      end

      def category_top_topics_full(category_slug)
        response = get("/c/#{category_slug}/l/top.json")
        response[:body]
      end

      def category_new_topics(category_slug)
        response = category_new_topics_full(category_slug)
        response["topic_list"]["topics"]
      end

      def category_new_topics_full(category_slug)
        response = get("/c/#{category_slug}/l/new.json")
        response[:body]
      end

      def category(id)
        response = get("/c/#{id}/show")
        response[:body]["category"]
      end

      # TODO: Deprecated. Remove after 20210727
      def category_set_user_notification(args = {})
        category_id = args[:id]
        args = API.params(args).required(:notification_level)
        post("/category/#{category_id}/notifications", args)
      end

      def category_set_user_notification_level(category_id, params)
        params = API.params(params).required(:notification_level)
        post("/category/#{category_id}/notifications", params)
      end

      private

      def common_category_params(args, include_id: false)
        params = API.params(args)
        params = params.required(:id) if include_id
        params
          .required(:name)
          .optional(
            :color,
            :text_color,
            :slug,
            :permissions,
            :auto_close_hours,
            :auto_close_based_on_last_post,
            :position,
            :email_in,
            :email_in_allow_strangers,
            :logo_url,
            :background_url,
            :allow_badges,
            :topic_template,
            :custom_fields,
            :description,
            :reviewable_by_group_name,
            :show_subcategory_list,
            :subcategory_list_style,
            :allowed_tags,
            :allowed_tag_groups,
            :required_tag_group_name,
            :topic_featured_links_allowed,
            :search_priority,
            :form_template_ids,
          )
          .default(parent_category_id: nil)
      end
    end
  end
end
