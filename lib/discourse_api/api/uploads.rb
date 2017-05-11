module DiscourseApi
  module API
    module Uploads
      def upload_file(args)
        args = API.params(args)
                  .optional(:file, :url)
                  .default(type: 'composer', synchronous: true)
                  .to_h
        post('/uploads', args)
      end
    end
  end
end
