# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config['host'] || 'http://localhost:3000')
client.api_key = config['api_key'] || "YOUR_API_KEY"
client.api_username = config['api_username'] || "YOUR_USERNAME"

# generate user api key
response = client.generate_user_api_key(
  key: {
    description: "Key to The Batmobile",
    username: "batman"
  }
)

puts response
# sample output: {"key"=>{"id"=>13, "key"=>"abc", "truncated_key"=>"abc", "description"=>"Key to The Batmobile"}}
