# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# create user
user = client.create_user(
  name: "Bruce Wayne",
  email: "bruce@wayne.com",
  username: "batman",
  password: "WhySoSerious"
)

# activate user
client.activate(user["user_id"])
