# require 'discourse_api'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# invite to a topic
client.invite_user_to_topic(email: "foo@bar.com", topic_id: 1)

# if the user is an admin you may invite to a group as well
client.invite_user_to_topic(email: "foo@bar.com", topic_id: 1, group_ids: "1,2,3")
