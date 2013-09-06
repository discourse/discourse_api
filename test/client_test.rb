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
      client = DiscourseApi::Client.new('localhost')
      assert_respond_to(client, :topic_invite_user)
    end

  end

  describe "topics" do

    before do
      @client = DiscourseApi::Client.new('localhost')
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
      @client = DiscourseApi::Client.new('localhost')
    end

    it "responds to categories" do
      assert_respond_to(@client, :categories)
    end

  end

end
