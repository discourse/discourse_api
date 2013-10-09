# DiscourseApi

[![Code Climate](https://codeclimate.com/github/discourse/discourse_api.png)](https://codeclimate.com/github/discourse/discourse_api)

The Discourse API gem allows you to consume the Discourse API

## Installation

Add this line to your application's Gemfile:

    gem 'discourse_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install discourse_api

## Usage

Over time this project intends to have a full Discourse API, at the moment there is only one endpoint

```ruby

client = DiscourseApi::Client.new("l.discourse")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.topic_invite_user(topic_id: 1794, email: "bob@bob.com")

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
