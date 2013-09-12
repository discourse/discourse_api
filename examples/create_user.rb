require 'discourse_api'

# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
# require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("forum.staging.makerist.de")
client.api_key = "5804eb67134f62d51ba29e6cfa8ce026f5d3891a8cace02c115ab72896fb1c52" # "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# honeypot_response = JSON.parse client.users_honeypot({})

# user_hash = {
#   name: "test name",
#   username: "testusername",
#   email: "test@foo.com",
#   password: "123456",
#   password_confirmation: honeypot_response["value"],
#   challenge: honeypot_response["challenge"].reverse
# }

# client.create_user(user_hash)

client.create_user_past_honeypot({
  name: "test name 2",
  username: "testusername2",
  email: "test2@foo.com",
  password: "123456"
})
