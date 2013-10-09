# require 'discourse_api'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("localhost", 3000)
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

puts client.username_update(username: "Batman", new_username: "Alfred")
puts client.user_update(username: "Batman", name: "Bruce Wayne")
puts client.email_update(username: "Batman", email: "batman@example.com")
puts client.toggle_avatar(username: "Batman", use_uploaded_avatar: true)
puts client.upload_avatar(username: "DiscourseHero", file: "http://cdn.discourse.org/assets/logo.png")
