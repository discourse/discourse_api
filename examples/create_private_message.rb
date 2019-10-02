# frozen_string_literal: true
require_relative 'example_helper'

client.create_private_message(
  title: "Confidential: Hello World!",
  raw: "This is the raw markdown for my private message",
  target_usernames: "user1,user2"
)
