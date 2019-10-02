# frozen_string_literal: true
# requires this plugin => https://github.com/discourse/discourse-invite-tokens

require 'csv'
require_relative 'example_helper'

# fetch email-less invite tokens
invite_tokens = client.disposable_tokens(username: "eviltrout", quantity: 5, group_names: "security,support")

# write to CSV file
CSV.open(File.expand_path("../invite_tokens.csv", __FILE__), "w") do |csv|
  invite_tokens.each do |value|
    csv << [value]
  end
end
