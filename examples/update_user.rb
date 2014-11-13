$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# update username from "robin" to "batman"
puts client.update_username("robin", "batman")
# update name of user whose username is "batman"
puts client.update_user("batman", name: "Bruce Wayne")
# update email of user whose username is "batman"
puts client.update_email("batman", "batman@gotham.com")
# update avatar of user whose username is "batman"
puts client.update_avatar("batman", "http://meta-discourse.r.worldssl.net/uploads/default/2497/724a6ef2e79d2bc7.png")
# log out everywhere and refresh browser of user whose id is "2"
puts client.log_out_and_refresh_browser(2)
