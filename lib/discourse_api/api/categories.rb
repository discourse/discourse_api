module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      def create_category(name:, color:, text_color:, parent_category_id: nil)
        post("/categories",
             name: name,
             color: color,
             text_color: text_color,
             parent_category_id: parent_category_id)
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
