# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

response =
  client.create_topic(
    category: 1,
    skip_validations: true,
    auto_track: false,
    title: "Concert Master: A new way to choose",
    raw: "This is the raw markdown for my post",
  )

# get topic_id from response
topic_id = response["topic_id"]

##
# available options (guessing from reading discourse source)
# status can be: ['autoclose', 'closed', 'archived', 'disabled', 'visible']
# enabled can be: [true, false]
##

# lock topic (note: api_username determines user that is performing action)
params = { status: "closed", enabled: true, api_username: "YOUR USERNAME/USERS USERNAME" }
client.change_topic_status(topic_id, params)

# unlock topic (note: api_username determines user that is performing action)
params = { status: "closed", enabled: false, api_username: "YOUR USERNAME/USERS USERNAME" }
client.change_topic_status(topic_id, params)
