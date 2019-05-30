# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.create_topic(
  category: 1,
  skip_validations: true,
  auto_track: false,
  title: "Concert Master: A new way to choose",
  raw: "This is the raw markdown for my post"
)

# create Poll topic
client.create_topic(
  category: 2,
  skip_validations: false,
  auto_track: false,
  title: "Your Favorite Color?",
  raw: "[poll name=color]\n- Green\n- Blue\n- Red\n[/poll]"
)
