# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

response = client.create_group(name: "engineering_team")
group_id = response["basic_group"]["id"]

client.group_add(group_id, username: "sam")
client.group_add(group_id, username: "jeff")
client.group_add(group_id, usernames: %w[neil dan])
client.group_add(group_id, user_id: 123)
client.group_add(group_id, user_ids: [123, 456])

client.group_remove(group_id, username: "neil")
client.group_remove(group_id, user_id: 123)

client.delete_group(group_id)

## List users of a group

members = client.group_members("trust_level_0")
puts members
