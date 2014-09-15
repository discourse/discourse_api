require 'spec_helper'

describe DiscourseApi::API::Users do
  subject { DiscourseApi::Client.new("http://localhost:3000") }

  describe "#user" do
    before do
      stub_get("http://localhost:3000/users/test.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.user("test")
      expect(a_get("http://localhost:3000/users/test.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested user" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      user = subject.user("test")
      expect(user).to be_a Hash
    end
  end

  describe "#update_avatar" do
    it "needs to have a test written for it"
  end

  describe "#update_email" do
    before do
      stub_put("http://localhost:3000/users/fake_user/preferences/email?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_user.json"), headers: { content_type: "application/json" })
    end

    it "makes the put request" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.update_email("fake_user", "fake_user_2@example.com")
      expect(a_put("http://localhost:3000/users/fake_user/preferences/email?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      response = subject.update_email("fake_user", "fake_user_2@example.com")
      expect(response[:body]['success']).to be_truthy
    end
  end

  describe "#update_user" do
    before do
      stub_put("http://localhost:3000/users/fake_user?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_user.json"), headers: { content_type: "application/json" })
    end

    it "makes the put request" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.update_user("fake_user", name: "Fake User 2")
      expect(a_put("http://localhost:3000/users/fake_user?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      response = subject.update_user("fake_user", name: "Fake User 2")
      expect(response[:body]['success']).to be_truthy
    end
  end

  describe "#update_username" do
    before do
      stub_put("http://localhost:3000/users/fake_user/preferences/username?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_username.json"), headers: { content_type: "application/json" })
    end

    it "makes the put request" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.update_username("fake_user", "fake_user_2")
      expect(a_put("http://localhost:3000/users/fake_user/preferences/username?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      response = subject.update_username("fake_user", "fake_user_2")
      expect(response[:body]['success']).to be_truthy
    end
  end

  describe "#create_user" do
    before do
      stub_post("http://localhost:3000/users?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_create_success.json"), headers: { content_type: "application/json" })
      stub_get("http://localhost:3000/users/hp.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: {"value"=>"foo", "challenge"=>"bar"}.to_json, headers: { content_type: "application/json" })
    end

    it "makes the post request" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.create_user :name => "Test User", :email => "test2@example.com", :password => "P@ssword", :username => "test2"
      expect(a_post("http://localhost:3000/users?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      response = subject.create_user :name => "Test User", :email => "test2@example.com", :password => "P@ssword", :username => "test2"
      expect(response[:body]['success']).to be_truthy
    end
  end
end
