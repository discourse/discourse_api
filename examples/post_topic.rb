# require 'discourse_api'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("localhost", 3000)
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.post_create(
  category: "Boing Boing",
  skip_validations: true,
  auto_track: false,
  title: "Concert Master: A new way to choose",
  raw: "This is the raw markdown for my post"
)
