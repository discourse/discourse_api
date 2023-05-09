# frozen_string_literal: true
# requires this plugin => https://github.com/discourse/discourse-invite-tokens

require "csv"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# fetch email-less invite tokens
invite_tokens =
  client.disposable_tokens(username: "eviltrout", quantity: 5, group_names: "security,support")

# write to CSV file
CSV.open(File.expand_path("../invite_tokens.csv", __FILE__), "w") do |csv|
  invite_tokens.each { |value| csv << [value] }
end
