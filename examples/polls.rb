# frozen_string_literal: true

require_relative 'example_helper'

options = ['8b4736b1ae3dfb5a28088530f036f9e5']
poll_option_votes = client.poll_vote post_id: 5, poll_name: 'poll', options: options
puts poll_option_votes.body['vote']

poll_option_votes = client.toggle_poll_status(post_id: 5, poll_name: 'poll', status: 'closed')
puts poll_option_votes[:body]['poll']['status']

poll_option_votes = client.poll_voters(post_id: 5, poll_name: 'poll')
puts poll_option_votes['voters']
