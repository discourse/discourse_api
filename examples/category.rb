# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# get categories
puts client.categories()

# get sub categories for parent category with id 2
puts client.categories(parent_category_id: 2)

# get the full categories response
puts client.categories_full()

# List topics in a category
category_topics = client.category_latest_topics(category_slug: "test-category")
puts category_topics

# List topics in a category paged
category_topics_paged = client.category_latest_topics(category_slug: "test-category", page: "5")
puts category_topics_paged

# update category notification_level
update_response =
  client.category_set_user_notification(
    id: "test-id",
    notification_level: "test-notification-level",
  )
puts update_response
