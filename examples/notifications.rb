# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# watch an entire category
client.category_set_user_notification_level(1, notification_level: 3)

# mute a topic
client.topic_set_user_notification_level(1, notification_level: 0)

# get user notifications
client.notifications(username: "discourse")
