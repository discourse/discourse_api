# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::UserActions do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#user_replies" do
    before do
      stub_get("#{host}/user_actions.json?username=testuser&filter=5").to_return(
        body: fixture("replies.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.user_replies("testuser")
      expect(a_get("#{host}/user_actions.json?username=testuser&filter=5")).to have_been_made
    end

    it "returns the requested user" do
      replies = client.user_replies("testuser")
      expect(replies).to be_an Array
    end
  end

  describe "#user_topics_and_replies" do
    before do
      stub_get("#{host}/user_actions.json?username=testuser&filter=4,5").to_return(
        body: fixture("replies_and_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.user_topics_and_replies("testuser")
      expect(a_get("#{host}/user_actions.json?username=testuser&filter=4,5")).to have_been_made
    end

    it "returns the requested user" do
      replies = client.user_topics_and_replies("testuser")
      expect(replies).to be_an Array
    end
  end
end
