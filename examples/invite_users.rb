# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# invite user
invite = client.invite_user(email: "name@example.com", group_ids: "41,42")

#update invite
client.update_invite(invite["id"], email: "namee@example.com")

# resend invite
client.resend_invite("namee@example.com")

# invite to a topic
client.invite_to_topic(1, email: "foo@bar.com")

# if the user is an admin you may invite to a group as well
client.invite_to_topic(1, email: "foo@bar.com", group_ids: "1,2,3")

# retrieve invite
puts client.retrieve_invite(email: "foo@bar.com")

# resend all invites
client.resend_all_invites

# destroy invite
client.destroy_invite(invite["id"])

# destroy all expired invites
client.destroy_all_expired_invites
