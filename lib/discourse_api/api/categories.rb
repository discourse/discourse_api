module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      def create_category(args)
        args = API.params(args)
                  .required(:name, :color, :text_color)
                  .optional(:description)
                  .default(parent_category_id: nil)
        response = post("/categories", args)
        response['category']
      end

      def categories(params={})
        response = get('/categories.json', params)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(category_slug)
        response = get("/category/#{category_slug}/l/latest.json")
        response[:body]['topic_list']['topics']
      end

      def category(id)
        response = get("/c/#{id}/show")
        response.body['category']
      end
    end
  end
end
