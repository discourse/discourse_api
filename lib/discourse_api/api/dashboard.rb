# frozen_string_literal: true
module DiscourseApi
  module API
    module Dashboard
      def get_dashboard_stats
        response = get("admin/dashboard.json")
        response[:body]
      end

      def get_dashboard_stats_totals
        stats = get_dashboard_stats
        global_reports = stats["global_reports"]
        users = global_reports[1]
        topics = global_reports[3]
        posts = global_reports[4]

        { "users" => users["total"], "topics" => topics["total"], "posts" => posts["total"] }
      end
    end
  end
end
