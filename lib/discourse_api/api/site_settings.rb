module DiscourseApi
  module API
    module SiteSettings
      def site_setting_update(args={})
        params = API.params(args)
                  .required(:name, :value).to_h
        new_site_setting = { params[:name] => params[:value] }
        response = put("/admin/site_settings/#{params[:name]}", new_site_setting)
      end
    end
  end
end
