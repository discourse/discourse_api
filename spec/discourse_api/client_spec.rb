require 'spec_helper'

describe DiscourseApi::Client do
  describe ".new" do
    it "requires a host argument" do
      lambda { DiscourseApi::Client.new }.must_raise ArgumentError
    end

    it "defaults api key to nil" do
      client = DiscourseApi::Client.new('http://localhost')
      client.api_key.must_be_nil
    end

    it "defaults api username to nil" do
      client = DiscourseApi::Client.new('http://localhost')
      client.api_username.must_be_nil
    end

    it "accepts an api key argument" do
      client = DiscourseApi::Client.new('http://localhost', 'test')
      client.api_key.must_be :==, 'test'
    end

    it "accepts an api username argument" do
      client = DiscourseApi::Client.new('http://localhost', 'test', 'test_user')
      client.api_username.must_be :==, 'test_user'
    end
  end

  describe "API methods" do
    subject { DiscourseApi::Client.new('http://localhost') }

    it { subject.must_respond_to :categories }
    it { subject.must_respond_to :hot_topics }
    it { subject.must_respond_to :invite_user_to_topic }
    it { subject.must_respond_to :latest_topics }
  end
end
