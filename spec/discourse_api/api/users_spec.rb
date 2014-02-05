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
    before do
      stub_post("http://localhost/users").to_return(body: fixture("user_create_success.json"), headers: { content_type: "application/json" })
      stub_get("http://localhost/users/hp.json").to_return(body: {"value"=>"foo", "challenge"=>"bar"}.to_json, headers: { content_type: "application/json" })
    end

    it "makes the post request" do
      subject.create_user :name => "Test User", :email => "test@example.com", :password => "P@ssword", :username => "test-user"
      expect(a_post("http://localhost/users")).to have_been_made
    end

    it "returns success" do
      response = subject.create_user :name => "Test User", :email => "test@example.com", :password => "P@ssword", :username => "test-user"
      expect(response[:body]['success']).to be_true
    end
  end
end