# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)
require 'yaml'

config_yml = File.expand_path('../config.yml', __FILE__)

begin
  CONFIG = YAML.load_file config_yml
rescue Errno::ENOENT
  raise ArgumentError, '/examples/config.yml file not found. Please copy config-example.yml to create a config.yml for your environment.'
end

def client
  discourse_client = DiscourseApi::Client.new CONFIG['host']
  discourse_client.api_key = CONFIG['api_key']
  discourse_client.api_username = CONFIG['api_username']
  discourse_client
end
