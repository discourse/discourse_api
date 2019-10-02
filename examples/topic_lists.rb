# frozen_string_literal: true
require_relative 'example_helper'

# get latest topics
puts client.latest_topics({})

# recategorize topic
puts client.recategorize_topic(topic_id: 108, category_id: 5)

# get all categories
puts client.categories({})
