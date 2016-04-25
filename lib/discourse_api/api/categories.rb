module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      # :permissions is a hash with the group name and permission_type which is
      # an integer 1 = Full 2 = Create Post 3 = Read Only
      def create_category(args={})
        args = API.params(args)
                  .required(:name, :color, :text_color)
                  .optional(:description, :permissions)
                  .default(parent_category_id: nil)
        response = post("/categories", args)
        response['category']
      end

      def categories(params={})
        response = get('/categories.json', params)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(args={})
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
        response.body['category']
      end
    end
  end
end
