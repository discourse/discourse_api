# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# get all dashboard status as json
puts client.get_dashboard_stats

# get hash of some dashboard total value
puts client.get_dashboard_stats_totals
# sample output: {"users"=>9, "topics"=>230, "posts"=>441}
