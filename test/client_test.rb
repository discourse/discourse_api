require 'discourse_api'
require 'minitest/autorun'
require 'minitest/pride'

class ClientTest < Minitest::Test

  describe "client basics" do

    it "should require a host argument" do
      assert_raises(ArgumentError) { DiscourseApi::Client.new }
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
      @client = DiscourseApi::Client.new('http://localhost')
    end

    it "responds to topics_latest" do
      assert_respond_to(@client, :topics_latest)
    end

    it "responds to topics_hot" do
      assert_respond_to(@client, :topics_hot)
    end

  end

  describe "categories" do

    before do
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
