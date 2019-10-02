# frozen_string_literal: true
require_relative 'example_helper'

# get all dashboard status as json
puts client.get_dashboard_stats

# get hash of some dashboard total value
puts client.get_dashboard_stats_totals
# sample output: {"users"=>9, "topics"=>230, "posts"=>441}
