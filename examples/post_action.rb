# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# Post Action Type IDs
# 1 - Bookmark
# 2 - Like
# 3 - Flag: Off-topic
# 4 - Flag: Inappropriate
# 5 - Vote
# 6 - Notify User
# 7 - Flag - Notify Moderators
# 8 - Flag - Spam

# Like a post
client.create_post_action(id: 2, post_action_type_id: 2)

# Flag a topic as spam
client.create_topic_action(id: 1, post_action_type_id: 8)

# Unlike a post
client.destroy_post_action(id: 3, post_action_type_id: 2)
