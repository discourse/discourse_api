require 'discourse_api'

# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
# require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("localhost",3000)
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.topic_invite_user(topic_id: 1794, email: "bob@bob.com")
