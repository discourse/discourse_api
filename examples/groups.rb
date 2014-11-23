$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

Dotenv.load
client = DiscourseApi::Client.new

response = client.create_group(name: "engineering_team")
group_id = response["basic_group"]["id"]

client.group_add(group_id, "sam")
client.group_add(group_id, "jeff")
client.group_add(group_id, "neil")

client.group_remove(group_id, "neil")
