$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# Upload an image via file
client.upload_post_image(file: 'grumpy_cat.gif')

# Upload an image via URL
client.upload_post_image(url: 'https://giphy.com/grumpy_cat.gif')
