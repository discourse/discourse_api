# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Topics do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#change_topic_status" do
    before do
      stub_put("#{host}/t/57/status").to_return(
        body: fixture("topic.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "changes the topic status" do
      client.update_topic_status(57, { status: "visible", enabled: false })
      expect(a_put("#{host}/t/57/status")).to have_been_made
    end
  end

  describe "#invite_to_topic" do
    before do
      stub_post("#{host}/t/12/invite").to_return(
        body: fixture("topic_invite_user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.invite_to_topic(12, email: "fake_user@example.com")
      expect(a_post("#{host}/t/12/invite")).to have_been_made
    end

    it "returns success" do
      response = client.invite_to_topic(12, email: "fake_user@example.com")
      expect(response).to be_a Hash
      expect(response["success"]).to be_truthy
    end
  end

  describe "#latest_topics" do
    before do
      stub_get("#{host}/latest.json").to_return(
        body: fixture("latest.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.latest_topics
      expect(a_get("#{host}/latest.json")).to have_been_made
    end

    it "returns the requested topics" do
      topics = client.latest_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end

    it "can take a hash param" do
      topics = client.latest_topics({})
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#top_topics" do
    before do
      stub_get("#{host}/top.json").to_return(
        body: fixture("top.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.top_topics
      expect(a_get("#{host}/top.json")).to have_been_made
    end

    it "returns the requested topics" do
      topics = client.top_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end

    it "can take a hash param" do
      topics = client.top_topics({})
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#new_topics" do
    before do
      stub_get("#{host}/new.json").to_return(
        body: fixture("new.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.new_topics
      expect(a_get("#{host}/new.json")).to have_been_made
    end

    it "returns the requested topics" do
      client.api_username = "test_user"
      topics = client.new_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#topic" do
    before do
      stub_get("#{host}/t/57.json").to_return(
        body: fixture("topic.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.topic(57)
      expect(a_get("#{host}/t/57.json")).to have_been_made
    end

    it "returns the requested topic" do
      topic = client.topic(57)
      expect(topic).to be_a Hash
      expect(topic["id"]).to eq(57)
    end
  end

  describe "#update_topic" do
    before do
      stub_put("#{host}/t/57.json").to_return(
        body: fixture("topic.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "renames the topic" do
      client.rename_topic(57, "A new title!")
      expect(a_put("#{host}/t/57.json")).to have_been_made
    end

    it "assigns the topic a new category" do
      client.recategorize_topic(57, 3)
      expect(a_put("#{host}/t/57.json")).to have_been_made
    end
  end

  describe "#topics_by" do
    before do
      stub_get("#{host}/topics/created-by/test.json").to_return(
        body: fixture("topics_created_by.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.topics_by("test")
      expect(a_get("#{host}/topics/created-by/test.json")).to have_been_made
    end

    it "returns the requested topics" do
      topics = client.topics_by("test")
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#topic_posts" do
    before do
      stub_get(%r{#{host}/t/57/posts\.json}).to_return(
        body: fixture("topic_posts.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.topic_posts(57)
      expect(a_get("#{host}/t/57/posts.json")).to have_been_made
    end

    it "allows scoping to specific post ids" do
      client.topic_posts(57, [123, 456])
      expect(a_get("#{host}/t/57/posts.json?post_ids[]=123&post_ids[]=456")).to have_been_made
    end

    it "returns the requested topic posts" do
      body = client.topic_posts(57, [123])
      expect(body).to be_a Hash
      expect(body["post_stream"]["posts"]).to be_an Array
      expect(body["post_stream"]["posts"].first).to be_a Hash
    end

    it "can retrieve a topic posts' raw attribute" do
      body = client.topic_posts(57, [123], { include_raw: true })
      expect(body).to be_a Hash
      expect(body["post_stream"]["posts"]).to be_an Array
      expect(body["post_stream"]["posts"].first).to be_a Hash
      expect(body["post_stream"]["posts"].first["raw"]).to be_an Array
    end
  end

  describe "#create_topic_with_tags" do
    before do
      stub_post("#{host}/posts").to_return(
        body: fixture("create_topic_with_tags.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the post request" do
      client.create_topic title: "Sample Topic Title",
                          raw: "Sample topic content body",
                          tags: %w[asdf fdsa]
      expect(a_post("#{host}/posts")).to have_been_made
    end

    it "returns success" do
      response =
        client.create_topic title: "Sample Topic Title",
                            raw: "Sample topic content body",
                            tags: %w[asdf fdsa]
      expect(response).to be_a Hash
      expect(response["topic_id"]).to eq 21
    end
  end

  describe "#topic_set_user_notification_level" do
    before do
      stub_post("#{host}/t/1/notifications").to_return(
        body: fixture("notification_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the post request" do
      response = client.topic_set_user_notification_level(1, notification_level: 3)
      expect(
        a_post("#{host}/t/1/notifications").with(body: "notification_level=3"),
      ).to have_been_made
      expect(response["success"]).to eq("OK")
    end
  end

  describe "#bookmark_topic" do
    before do
      stub_put("#{host}/t/1/bookmark.json").to_return(
        body: "",
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      response = client.bookmark_topic(1)
      expect(a_put("#{host}/t/1/bookmark.json")).to have_been_made
      expect(response.body).to eq(nil)
    end
  end

  describe "#remove_topic_bookmark" do
    before do
      stub_put("#{host}/t/1/remove_bookmarks.json").to_return(
        body: "",
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      response = client.remove_topic_bookmark(1)
      expect(a_put("#{host}/t/1/remove_bookmarks.json")).to have_been_made
      expect(response.body).to eq(nil)
    end
  end
end
