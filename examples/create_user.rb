# frozen_string_literal: true
require_relative 'example_helper'

# create user
user = client.create_user(
  name: "Bruce Wayne",
  email: "bruce@wayne.com",
  username: "batman",
  password: "WhySoSerious"
)

# activate user
client.activate(user["user_id"])
