# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

###
# Required category params:
#   :name, :color, :text_color
# Optional category params:
#   :slug, :permissions, :auto_close_hours, :auto_close_based_on_last_post, :position, :email_in,
#   :email_in_allow_strangers, :logo_url, :background_url, :allow_badges, :topic_template
###

# Create category
new_category = client.create_category(name: "Test Category", color: "AB9364", text_color: "FFFFFF")
puts "Created category: " + new_category.to_s

# Update category
response =
  client.update_category(
    id: new_category["id"],
    name: "The Best Test Category",
    slug: "the-best-test-category",
    color: "0E76BD",
    text_color: "000000",
  )
puts "Updated category: " + response.to_s
