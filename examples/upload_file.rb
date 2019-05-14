# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

# Upload a file
file = Faraday::UploadIO.new('grumpy_cat.pdf', "application/pdf")
client.upload_file(file: file)

# Upload a file via URL
client.upload_file(url: 'https://giphy.com/grumpy_cat.gif')
