module DiscourseApi
  module API
    module Categories
      def categories(*args)
        response = get('/categories.json', args)
        response[:body]['category_list']['categories']
      end
    end
  end
end
