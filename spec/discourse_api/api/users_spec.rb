require 'spec_helper'

describe DiscourseApi::API::Users do
  subject { DiscourseApi::Client.new("http://localhost") }

  describe "#toggle_avatar" do
    it "needs to have a test written for it"
  end

  describe "#user" do
    before do
      stub_get("http://localhost/users/test_user.json").to_return(body: fixture("user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.user("test_user")
      expect(a_get("http://localhost/users/test_user.json")).to have_been_made
    end

    it "returns the requested user" do
      user = subject.user("test_user")
      expect(user).to be_a Hash
    end
  end

  describe "#update_avatar" do
    it "needs to have a test written for it"
  end

  describe "#update_email" do
    it "needs to have a test written for it"
  end

  describe "#update_user" do
    it "needs to have a test written for it"
  end

  describe "#update_username" do
    it "needs to have a test written for it"
  end

  describe "#create_user" do
    it "needs to have a test written for it"
  end
end