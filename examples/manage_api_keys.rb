# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# generate user api key
response = client.create_api_key(key: { description: "Key to The Batmobile", username: "batman" })

api_key_id = response["key"]["id"]

puts response
# sample output: {"key"=>{"id"=>13, "key"=>"abc", "description"=>"Key to the Batmobile"}}

response = client.revoke_api_key(api_key_id)

puts response
# sample output: {"key"=>{"id"=>13, "key"=>"abc", "description"=>"Key to the Batmobile", "revoked_at"=>"2021-01-01T00:00:00.000Z"}}

response = client.undo_revoke_api_key(api_key_id)

puts response
# sample output: {"key"=>{"id"=>13, "key"=>"abc", "description"=>"Key to the Batmobile", "revoked_at"=>nil}}

response = client.list_api_keys

puts response
# sample output: {"keys"=>[{"id"=>13, "key"=>"abc", "description"=>"Key to the Batmobile"}]}

response = client.delete_api_key(api_key_id)

puts response
# sample output: {"success"=>"OK"}
