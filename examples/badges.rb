# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# get badges
puts client.badges

# get badges for a user
puts client.user_badges("test-user")

# Grants a badge to a user.
puts client.grant_user_badge(badge_id: 9, username: "test-user", reason: "Really nice person")

# Creates a new badge

###
# Required params:
#   :name, :badge_type_id (gold: 1, bronze: 3, silver: 2)
# Optional params:
#   :description, :allow_title, :multiple_grant, :icon, :listable,
#   :target_posts, :query, :enabled, :auto_revoke, :badge_grouping_id,
#   :trigger, :show_posts, :image, :long_description
###

puts client.create_badge(name: "Shiny new badge", badge_type_id: 1)
