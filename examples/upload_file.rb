# frozen_string_literal: true
require_relative 'example_helper'

# Upload a file
file = Faraday::UploadIO.new('grumpy_cat.pdf', "application/pdf")
client.upload_file(file: file)

# Upload a file via URL
client.upload_file(url: 'https://giphy.com/grumpy_cat.gif')
