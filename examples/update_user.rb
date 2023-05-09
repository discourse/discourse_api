# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# update username from "robin" to "batman"
puts client.update_username("robin", "batman")
# update name of user whose username is "batman"
puts client.update_user("batman", name: "Bruce Wayne")
# update email of user whose username is "batman"
puts client.update_email("batman", "batman@gotham.com")
# update avatar of user whose username is "batman"
puts client.update_avatar(
       username: "batman",
       url: "http://meta-discourse.r.worldssl.net/uploads/default/2497/724a6ef2e79d2bc7.png",
     )
# update trust level of user whose id is "102"
puts client.update_trust_level(user_id: 102, level: 2)
# update user bio, location or website
puts client.update_user(
       "batman",
       bio_raw: "I am Batman.",
       location: "Gotham",
       website: "https://en.wikipedia.org/wiki/Batman",
     )

# log out everywhere and refresh browser of user whose id is "2"
puts client.log_out(2)
