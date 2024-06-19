# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Polls do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#poll vote" do
    before do
      path = "#{host}/polls/vote"
      stub_put(path).to_return(
        body: fixture("polls_vote.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      options = ["8b4736b1ae3dfb5a28088530f036f9e5"]
      client.poll_vote post_id: 5, poll_name: "poll", options: options
      expect(a_put("#{host}/polls/vote")).to have_been_made
    end

    it "returns the expected votes" do
      options = ["8b4736b1ae3dfb5a28088530f036f9e5"]
      vote = client.poll_vote post_id: 5, poll_name: "poll", options: options
      expect(vote.body).to be_a Hash
      expect(vote.body["poll"]["options"]).to be_an Array
      expect(vote.body["vote"]).to eq(["8b4736b1ae3dfb5a28088530f036f9e5"])
    end

    describe "#poll toggle_status" do
      before do
        path = "#{host}/polls/toggle_status"
        stub_put(path).to_return(
          body: fixture("polls_toggle_status.json"),
          headers: {
            content_type: "application/json",
          },
        )
      end

      it "toggles the poll status to closed" do
        client.toggle_poll_status post_id: 5, poll_name: "poll", status: "closed"
        expect(a_put("#{host}/polls/toggle_status")).to have_been_made
      end

      it "returns the expected results of closed poll" do
        returned_poll_status =
          client.toggle_poll_status post_id: 5, poll_name: "poll", status: "closed"
        expect(returned_poll_status.body).to be_a Hash
        returned_poll_status.body["poll"]["options"].each { |g| expect(g).to be_a Hash }
      end
    end

    describe "#poll voters" do
      before do
        stub_get("#{host}/polls/voters.json?post_id=5&poll_name=poll").to_return(
          body: fixture("polls_voters.json"),
          headers: {
            content_type: "application/json",
          },
        )
      end

      it "requests the correct resource" do
        client.poll_voters post_id: 5, poll_name: "poll"
        expect(a_get("#{host}/polls/voters.json?post_id=5&poll_name=poll")).to have_been_made
      end

      it "returns the expected votes" do
        voters = client.poll_voters post_id: 5, poll_name: "poll"
        expect(voters).to be_a Hash
        voters.each { |g| expect(g).to be_an Array }
        expect(voters["voters"]["e539a9df8700d0d05c69356a07b768cf"]).to be_an Array
        expect(voters["voters"]["e539a9df8700d0d05c69356a07b768cf"][0]["id"]).to eq(356)
      end
    end
  end
end
