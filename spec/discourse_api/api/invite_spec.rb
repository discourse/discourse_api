# frozen_string_literal: true
require 'spec_helper'

describe DiscourseApi::API::Invite do
  subject { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#invite_user" do
    before do
      stub_post("#{host}/invites").to_return(body: fixture("topic_invite_user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.invite_user(email: "fake_user@example.com", group_ids: "41,42")
      expect(a_post("#{host}/invites")).to have_been_made
    end

    it "returns success" do
      response = subject.invite_user(email: "fake_user@example.com", group_ids: "41,42")
      expect(response).to be_a Hash
      expect(response['success']).to be_truthy
    end
  end

  describe "#update_invite" do
    before do
      stub_put("#{host}/invites/27").to_return(body: fixture("topic_invite_user.json"), headers: { content_type: "application/json" })
    end

    it "updates invite" do
      subject.update_invite(27, email: "namee@example.com")
      expect(a_put("#{host}/invites/27")).to have_been_made
    end
  end

  describe "#retrieve_invite" do
    before do
      stub_get("#{host}/invites/retrieve.json?email=foo@bar.com").to_return(body: fixture("retrieve_invite.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.retrieve_invite(email: "foo@bar.com")
      expect(a_get("#{host}/invites/retrieve.json?email=foo@bar.com")).to have_been_made
    end

    it "returns the requested topics" do
      invites = subject.retrieve_invite(email: "foo@bar.com")
      expect(invites).to be_an Hash
    end

    it "returns the requested invite" do
      invites = subject.retrieve_invite(email: "foo@bar.com")
      expect(invites["email"]).to eq("foo@bar.com")
      expect(invites).to have_key("invite_key")
    end
  end

  describe "#destroy_all_expired_invites" do
    let(:url) { "#{host}/invites/destroy-all-expired" }

    before do
      stub_post(url)
        .to_return(
          body: '{"success": "OK"}',
          headers: { content_type: "application/json" }
        )
    end

    it "destroys all expired invites" do
      subject.destroy_all_expired_invites
      expect(a_post(url)).to have_been_made
    end
  end

  describe "#resend_all_invites" do
    let(:url) { "#{host}/invites/reinvite-all" }

    before do
      stub_post(url)
        .to_return(
          body: '{"success": "OK"}',
          headers: { content_type: "application/json" }
        )
    end

    it "resends all invites" do
      subject.resend_all_invites
      expect(a_post(url)).to have_been_made
    end
  end

  describe "#resend_invite" do
    let(:url) { "#{host}/invites/reinvite" }

    before do
      stub_post(url)
        .to_return(
          body: '{"success": "OK"}',
          headers: { content_type: "application/json" }
        )
    end

    it "resends invite" do
      subject.resend_invite("foo@bar.com")
      expect(a_post(url)).to have_been_made
    end
  end

  describe "#destroy_invite" do
    let(:url) { "#{host}/invites?id=27" }

    before do
      stub_delete(url).to_return(
        body: '{"success": "OK"}',
        headers: { content_type: "application/json" }
      )
    end

    it "destroys the invite" do
      subject.destroy_invite(27)
      expect(a_delete(url)).to have_been_made
    end
  end
end
