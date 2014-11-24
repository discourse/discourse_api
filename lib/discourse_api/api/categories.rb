module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      def create_category(args)
        post("/categories", API.params(args)
                               .required(:name)
                               .optional(:color, :text_color)
                               .default(parent_category_id: nil)
            )
      end

      def categories(*args)
        response = get('/categories.json', args)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(category_slug)
        response = get("/category/#{category_slug}/l/latest.json")
        response[:body]['topic_list']['topics']
      end
    end
  end
end
