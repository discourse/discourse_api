require 'spec_helper'

describe DiscourseApi::Client do
  describe ".new" do
    it "requires a host argument" do
      lambda { DiscourseApi::Client.new }.must_raise ArgumentError
    end

    it "defaults port to 80" do
      client = DiscourseApi::Client.new('http://localhost')
      client.port.must_be :==, 80
    end

    it "accepts a port argument" do
      client = DiscourseApi::Client.new('http://localhost',3000)
      client.port.must_be :==, 3000
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
