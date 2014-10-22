module DiscourseApi
  module API
    module Categories
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
