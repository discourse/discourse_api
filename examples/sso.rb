# frozen_string_literal: true
require_relative 'example_helper'

client.sync_sso(
  sso_secret: "discourse_sso_rocks",
  name: "Test Name",
  username: "test_name",
  email: "name@example.com",
  external_id: "2"
)
