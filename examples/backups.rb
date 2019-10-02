# frozen_string_literal: true
require_relative 'example_helper'

# get list of backup files
puts client.backups()

# create backup
puts client.create_backup()

# restore backup
puts client.restore_backup("backup_file_name.tar.gz")

# download backup
puts client.download_backup("backup_file_name.tar.gz", "/tmp/")
