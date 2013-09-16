require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'

class ClientTest < Minitest::Test


  describe "client basics" do

    it "requires a host argument" do
      assert_raises(ArgumentError) { DiscourseApi::Client.new }
    end

    it "exposes the host argument" do
      host = 'http://localhost'
      client = DiscourseApi::Client.new(host)
      assert_equal(client.host, host)
    end

    it "the host argument is read-only for clients" do
      host = 'http://localhost'
      client = DiscourseApi::Client.new(host)
      assert_raises(NoMethodError) { client.host = 'http://another.host' }
    end

    it 'accepts the api_key as an optional argument' do
      api_key = 'abc123'
      client = DiscourseApi::Client.new('http://localhost', api_key)
      assert_equal(client.api_key, api_key)
    end

  end

  describe "topic invitations" do

    it "responds to topic_invite_user" do
      client = DiscourseApi::Client.new('http://localhost')
      assert_respond_to(client, :topic_invite_user)
    end

  end

  describe "topics" do

    before do
      stub_request(:get, "http://localhost/latest.json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => {"topic_list" => { "topics" => [{'id' => '00001', 'title' => 'Title', 'slug' => 'post_slug', 'posts_count' => 0}]} }.to_json, :headers => {})
      @client = DiscourseApi::Client.new('http://localhost')
    end

    describe "latest" do

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
      it "responds to topics_hot" do
        assert_respond_to(@client, :topics_hot)
      end
    end

  end

  describe "categories" do

    before do
      stub_request(:get, "http://localhost/categories.json").
  with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
  to_return(:status => 200, :body => {"category_list" => {"categories" => [{'name' => 'the_name', 'id' => '000001', 'description' => 'the info', 'topic_count' => 0}]}}.to_json, :headers => {})

      @client = DiscourseApi::Client.new('http://localhost')
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

end
