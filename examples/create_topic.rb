# frozen_string_literal: true
require_relative 'example_helper'

client.create_topic(
  category: 1,
  skip_validations: true,
  auto_track: false,
  title: "Concert Master: A new way to choose",
  raw: "This is the raw markdown for my post"
)

# create Poll topic
client.create_topic(
  category: 2,
  skip_validations: false,
  auto_track: false,
  title: "Your Favorite Color?",
  raw: "[poll name=color]\n- Green\n- Blue\n- Red\n[/poll]"
)
