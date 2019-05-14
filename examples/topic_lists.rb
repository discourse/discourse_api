# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# get latest topics
puts client.latest_topics({})

# recategorize topic
puts client.recategorize_topic(topic_id: 108, category_id: 5)

# get all categories
puts client.categories({})
