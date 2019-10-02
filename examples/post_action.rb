# frozen_string_literal: true
require_relative 'example_helper'

# Post Action Type IDs
# 1 - Bookmark
# 2 - Like
# 3 - Flag: Off-topic
# 4 - Flag: Inappropriate
# 5 - Vote
# 6 - Notify User
# 7 - Flag - Notify Moderators
# 8 - Flag - Spam

# Like a post
client.create_post_action(id: 2, post_action_type_id: 2)

# Flag a topic as spam
client.create_topic_action(id: 1, post_action_type_id: 8)

# Unlike a post
client.destroy_post_action(id: 3, post_action_type_id: 2)
