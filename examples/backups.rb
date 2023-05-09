# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/discourse_api", __FILE__)

config = DiscourseApi::ExampleHelper.load_yml

client = DiscourseApi::Client.new(config["host"] || "http://localhost:3000")
client.api_key = config["api_key"] || "YOUR_API_KEY"
client.api_username = config["api_username"] || "YOUR_USERNAME"

# get list of backup files
puts client.backups()

# create backup
puts client.create_backup()

# restore backup
puts client.restore_backup("backup_file_name.tar.gz")

# download backup
puts client.download_backup("backup_file_name.tar.gz", "/tmp/")
