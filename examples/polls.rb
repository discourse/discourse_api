# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

options = ["8b4736b1ae3dfb5a28088530f036f9e5"]
poll_option_votes = client.poll_vote post_id: 5, poll_name: "poll", options: options
puts poll_option_votes.body["vote"]

poll_option_votes = client.toggle_poll_status(post_id: 5, poll_name: "poll", status: "closed")
puts poll_option_votes[:body]["poll"]["status"]

poll_option_votes = client.poll_voters(post_id: 5, poll_name: "poll")
puts poll_option_votes["voters"]
