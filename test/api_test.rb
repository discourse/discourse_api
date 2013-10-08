require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'

class ClientTest < Minitest::Test


  describe "client basics" do

    it "requires a host argument" do
      assert_raises(ArgumentError) { DiscourseApi::Api.new }
    end

    it "exposes the host argument" do
      host = 'http://localhost'
      client = DiscourseApi::Api.new(host)
      assert_equal(client.host, host)
    end

    it "the host argument is read-only for clients" do
      host = 'http://localhost'
      client = DiscourseApi::Api.new(host)
      assert_raises(NoMethodError) { client.host = 'http://another.host' }
    end

    it 'accepts the api_key as an optional argument' do
      api_key = 'abc123'
      client = DiscourseApi::Api.new('http://localhost', api_key)
      assert_equal(client.api_key, api_key)
    end

    it 'accepts the api_username as an optional argument' do
      api_key = 'abc123'
      api_username = 'admin'
      client = DiscourseApi::Api.new('http://localhost', api_key, api_username)
      assert_equal(client.api_username, api_username)
    end

  end

  describe "topic invitations" do

    it "responds to topic_invite_user" do
      client = DiscourseApi::Api.new('http://localhost')
      assert_respond_to(client, :topic_invite_user)
    end

    it "sends a topic invitation request" do
      api_key = 'abc123'
      api_username = 'admin'
      client = DiscourseApi::Api.new('http://localhost', api_key, api_username)

      topic_id = 1
      invitee_email = "invitee@example.com"

      stub_request(:post, "http://localhost/t/#{topic_id}/invite.json").
        with(:body => "{\"email\":\"#{invitee_email}\",\"topic_id\":#{topic_id},\"api_key\":\"#{api_key}\",\"api_username\":\"#{api_username}\",\"topic\":{}}",
             :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => "", :headers => {})

      resp = client.topic_invite_user('invitee@example.com', 1)
      assert_equal(resp, 200)
    end

  end

  describe "topics" do

    describe "latest" do

      before do
        stub_request(:get, "http://localhost/latest.json").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
          to_return(:status => 200, :body => {"topic_list" => { "topics" => [{'id' => '00001', 'title' => 'Title', 'slug' => 'post_slug', 'posts_count' => 0}]} }.to_json, :headers => {})
        @client = DiscourseApi::Api.new('http://localhost')
      end

      it "responds to topics_latest" do
        assert_respond_to(@client, :topics_latest)
      end

      it 'responds with a list of categories' do
        @client.topics_latest.must_be_kind_of Enumerable
      end

      it 'has the right keys for a given category' do
        topic = @client.topics_latest.first
        topic.keys.must_include 'id'
        topic.keys.must_include 'title'
        topic.keys.must_include 'slug'
        topic.keys.must_include 'posts_count'
      end

    end

    describe "hot" do

      before do
        stub_request(:get, "http://localhost/hot.json").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
          to_return(:status => 200, :body => {"topic_list" => { "topics" => [{'id' => '00001', 'title' => 'Title', 'slug' => 'post_slug', 'posts_count' => 0}]} }.to_json, :headers => {})
        @client = DiscourseApi::Api.new('http://localhost')
      end

      it "responds to topics_hot" do
        assert_respond_to(@client, :topics_hot)
      end

      it 'responds with a list of categories' do
        @client.topics_hot.must_be_kind_of Enumerable
      end

      it 'has the right keys for a given category' do
        topic = @client.topics_hot.first
        topic.keys.must_include 'id'
        topic.keys.must_include 'title'
        topic.keys.must_include 'slug'
        topic.keys.must_include 'posts_count'
      end

    end

    describe "topic" do

      before do
        stub_request(:get, "http://localhost/t/1.json").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
          to_return(:status => 200, :body => {"post_stream" => {"stream" => [], "posts" => [{}] }, "id" => 1, "title" => 'Topic Title' }.to_json, :headers => {})
        @client = DiscourseApi::Api.new('http://localhost')
      end

      it "responds to topic" do
        assert_respond_to(@client, :topic)
      end

      it 'requires a topic_id as an argument' do
        assert_raises(ArgumentError) do
          @client.topic
        end
      end

      it 'responds with the topic' do
        @client.topic(1).must_be_kind_of Enumerable
      end


      it 'has the right keys for a given topic' do
        topic = @client.topic(1)
        topic.keys.must_include 'post_stream'
        topic.keys.must_include 'id'
        topic.keys.must_include 'title'
      end

      it 'has the right keys for a given topic post_stream' do
        post_stream = @client.topic(1)['post_stream']
        post_stream.keys.length.must_equal 2
        post_stream.keys.must_include 'stream'
        post_stream['stream'].must_be_kind_of Array
        post_stream.keys.must_include 'posts'
        post_stream['posts'].must_be_kind_of Array
      end
    end

  end

  describe "categories" do

    before do
      stub_request(:get, "http://localhost/categories.json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => {"category_list" => {"categories" => [{'name' => 'the_name', 'id' => '000001', 'description' => 'the info', 'topic_count' => 0}]}}.to_json, :headers => {})

      @client = DiscourseApi::Api.new('http://localhost')
    end

    it "responds to categories" do
      assert_respond_to(@client, :categories)
    end

    it 'responds with a list of categories' do
      @client.categories.must_be_kind_of Enumerable
    end

    it 'has the right keys for a given category' do
      category = @client.categories.first
      category.keys.must_include 'id'
      category.keys.must_include 'name'
      category.keys.must_include 'description'
      category.keys.must_include 'topic_count'
    end

  end

  describe "#post_create" do

    before do
      @client = DiscourseApi::Api.new('http://localhost')
    end

    it "responds to post_create" do
      assert_respond_to(@client, :post_create)
    end

  end

  describe "user basics" do

    before do
      @client = DiscourseApi::Api.new('http://localhost')
    end

    describe '#user' do

      before do
        stub_request(:get, "http://localhost/user/testuser.json").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
          to_return(:status => 200, :body => {"user" => {"username" => "testuser"}}.to_json, :headers => {})
      end

      it 'responds to user/:username' do
        assert_respond_to(@client, :user)
      end

      it 'responds with the user' do
        @client.user('testuser').must_be_kind_of Hash
      end

      it 'has the right keys for a user' do
        user = @client.user('testuser')
        user.keys.must_include 'username'
      end
    end

    describe '#user_update' do

      it "responds to user_update" do
        assert_respond_to(@client, :user_update)
      end

    end

    describe '#username_update' do

      it 'responds to username_update' do
        assert_respond_to(@client, :username_update)
      end

      it 'updates an existing username' do
        stub_request(:put, "http://localhost/users/original@example.com/preferences/username").
  with(:body => {"api_key"=>true, "api_username"=>true, "new_username"=>"new@example.com"},
       :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.8.8'}).
  to_return(:status => 200, :body => "", :headers => {})

        resp = @client.username_update('original@example.com', 'new@example.com')
        assert_equal(resp, 200)
      end

      it '404s on a non-existing username' do
        stub_request(:put, "http://localhost/users/missing@example.com/preferences/username").
  with(:body => {"api_key"=>true, "api_username"=>true, "new_username"=>"new@example.com"},
       :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.8.8'}).
  to_return(:status => 404, :body => "", :headers => {})

        resp = @client.username_update('missing@example.com', 'new@example.com')
        assert_equal(resp, 404)
      end
    end

    it 'responds to email_update' do
      assert_respond_to(@client, :email_update)
    end

    it 'responds to toggle_avatar' do
      assert_respond_to(@client, :toggle_avatar)
    end

  end

end
