# DiscourseApi

[![Build Status](https://travis-ci.org/discourse/discourse_api.pong?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/discourse/discourse_api.png)][codeclimate]

[travis]: http://travis-ci.org/discourse/discourse_api
[codeclimate]: https://codeclimate.com/github/discourse/discourse_api

The Discourse API gem allows you to consume the Discourse API

## Installation

Add this line to your application's Gemfile:

    gem 'discourse_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install discourse_api

## Usage

Over time this project intends to have a full Discourse API. At the moment there are only a
few endpoints available:

```ruby
client = DiscourseApi::Client.new("http://try.discourse.org")

# Topic endpoints
client.latest_topics      #=> Gets a list of the latest topics
client.hot_topics         #=> Gets a list of hot topics
client.new_topics         #=> Gets a list of new topics
client.topics_by("sam")   #=> Gets a list of topics created by user "sam"
client.topic(57)          #=> Gets the topic with id 57

# Search endpoint
client.search("sandbox")  #=> Gets a list of topics that match "sandbox"

# Categories endpoint
client.categories         #=> Gets a list of categories

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
