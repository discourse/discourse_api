# frozen_string_literal: true
require_relative 'example_helper'

# invite user
client.invite_user(email: "name@example.com", group_ids: "41,42")

# invite to a topic
client.invite_user_to_topic(email: "foo@bar.com", topic_id: 1)

# if the user is an admin you may invite to a group as well
client.invite_user_to_topic(email: "foo@bar.com", topic_id: 1, group_ids: "1,2,3")
