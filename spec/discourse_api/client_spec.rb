require 'spec_helper'

describe DiscourseApi::Client do
  subject { DiscourseApi::Client.new('http://localhost') }

  describe ".new" do
    it "requires a host argument" do
      expect { DiscourseApi::Client.new }.to raise_error ArgumentError
    end

    it "defaults api key to nil" do
      expect(subject.api_key).to be_nil
    end

    it "defaults api username to nil" do
      expect(subject.api_username).to be_nil
    end

    it "accepts an api key argument" do
      client = DiscourseApi::Client.new('http://localhost', 'test')
      expect(client.api_key).to eq('test')
    end

    it "accepts an api username argument" do
      client = DiscourseApi::Client.new('http://localhost', 'test', 'test_user')
      expect(client.api_username).to eq('test_user')
    end
  end

  describe "API methods" do
    it { should respond_to :categories }
    it { should respond_to :hot_topics }
    it { should respond_to :invite_user_to_topic }
    it { should respond_to :latest_topics }
  end
end
