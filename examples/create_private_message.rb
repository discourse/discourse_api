# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.create_private_message(
  title: "Confidential: Hello World!",
  raw: "This is the raw markdown for my private message",
  target_usernames: "user1,user2"
)
