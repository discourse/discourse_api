require 'spec_helper'

describe DiscourseApi::API::Topics do
  subject { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#change_topic_status" do
    before do
      stub_put("#{host}/t/57/status").to_return(body: fixture("topic.json"), headers: { content_type: "application/json" })
    end

    it "changes the topic status" do
      subject.change_topic_status(nil, 57, { status: 'visible', enabled: false })
      expect(a_put("#{host}/t/57/status")).to have_been_made
    end
  end

  describe "#invite_user_to_topic" do
    before do
      stub_post("#{host}/t/12/invite").to_return(body: fixture("topic_invite_user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.invite_user_to_topic(email: "fake_user@example.com", topic_id: 12)
      expect(a_post("#{host}/t/12/invite")).to have_been_made
    end

    it "returns success" do
      response = subject.invite_user_to_topic(email: "fake_user@example.com", topic_id: 12)
      expect(response).to be_a Hash
      expect(response['success']).to be_truthy
    end
  end

  describe "#latest_topics" do
    before do
      stub_get("#{host}/latest.json").to_return(body: fixture("latest.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.latest_topics
      expect(a_get("#{host}/latest.json")).to have_been_made
    end

    it "returns the requested topics" do
      topics = subject.latest_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end

    it "can take a hash param" do
      topics = subject.latest_topics({})
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#new_topics" do
    before do
      stub_get("#{host}/new.json").to_return(body: fixture("new.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.new_topics
      expect(a_get("#{host}/new.json")).to have_been_made
    end

    it "returns the requested topics" do
      subject.api_username = 'test_user'
      topics = subject.new_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#topic" do
    before do
      stub_get("#{host}/t/57.json").to_return(body: fixture("topic.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.topic(57)
      expect(a_get("#{host}/t/57.json")).to have_been_made
    end

    it "returns the requested topic" do
      topic = subject.topic(57)
      expect(topic).to be_a Hash
      expect(topic["id"]).to eq(57)
    end
  end

  describe "#update_topic" do
    before do
      stub_put("#{host}/t/57.json").to_return(body: fixture("topic.json"), headers: { content_type: "application/json" })
    end

    it "renames the topic" do
      subject.rename_topic(57, "A new title!")
      expect(a_put("#{host}/t/57.json")).to have_been_made
    end

    it "assigns the topic a new category" do
      subject.recategorize_topic(57, 3)
      expect(a_put("#{host}/t/57.json")).to have_been_made
    end
  end

  describe "#topics_by" do
    before do
      stub_get("#{host}/topics/created-by/test.json").to_return(body: fixture("topics_created_by.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.topics_by('test')
      expect(a_get("#{host}/topics/created-by/test.json")).to have_been_made
    end

    it "returns the requested topics" do
      topics = subject.topics_by('test')
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end
end
