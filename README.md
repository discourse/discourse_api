# DiscourseApi

[![Code Climate](https://codeclimate.com/github/discourse/discourse_api.png)][codeclimate]

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
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"

client.ssl(...)                                 #=> specify SSL connection settings if needed

# Topic endpoints
client.latest_topics                            #=> Gets a list of the latest topics
client.hot_topics                               #=> Gets a list of hot topics
client.new_topics                               #=> Gets a list of new topics
client.topics_by("sam")                         #=> Gets a list of topics created by user "sam"
client.topic(57)                                #=> Gets the topic with id 57

# Search endpoint
client.search("sandbox")                        #=> Gets a list of topics that match "sandbox"

# Categories endpoint
client.categories                               #=> Gets a list of categories
client.category_latest_posts("category-slug")   #=> Gets a list of latest posts in a category

# SSO endpoint
client.sync_sso(                                #=> Synchronizes the SSO record
  sso_secret: "discourse_sso_rocks",
  name: "Test Name",
  username: "test_name",
  email: "name@example.com",
  external_id: "2"
)
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Testing

1. Install discourse locally
2. Inside of your discourse directory, run: `bundle exec rake db:api_test_seed`
3. Start discourse: `bundle exec rails s`
4. Inside of your discourse_api directory, run: `bundle exec rspec spec/`

## The Shell

Configure the api by setting `DISCOURSE_API_URL`, `DISCOURSE_API_KEY`, `DISCOURSE_API_USERNAME` environment variables and start the Discourse API in a terminal:

` ./bin/shell `

Then, run (see examples) like this: `discourse> client.latest_topics`

Also, you can copy `env.example` to `.env` and modify it.
