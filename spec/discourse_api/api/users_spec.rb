require 'spec_helper'

describe DiscourseApi::API::Users do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#user" do
    before do
      stub_get("http://localhost:3000/users/test.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.user("test")
      expect(a_get("http://localhost:3000/users/test.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested user" do
      user = subject.user("test")
      expect(user).to be_a Hash
    end
  end

  describe "#update_avatar" do
    before do
      stub_post("http://localhost:3000/users/test_user/preferences/user_image?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_avatar_success.json"), headers: { content_type: "application/json" })
      stub_put("http://localhost:3000/users/test_user/preferences/avatar/pick?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_avatar_success.json"), headers: { content_type: "application/json" })
    end

    it "uploads an image" do
      sam = "https://meta-discourse.global.ssl.fastly.net/user_avatar/meta.discourse.org/sam/120/5243.png"
      args = { username: 'test_user', file: sam }
      response = subject.update_avatar(args)
      expect(response[:body]['success']).to eq('OK')
    end
  end

  describe "#update_email" do
    before do
      stub_put("http://localhost:3000/users/fake_user/preferences/email?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_update_user.json"), headers: { content_type: "application/json" })
    end

    it "makes the put request" do
      subject.update_email("fake_user", "fake_user_2@example.com")
      expect(a_put("http://localhost:3000/users/fake_user/preferences/email?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
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
      subject.update_username("fake_user", "fake_user_2")
      expect(a_put("http://localhost:3000/users/fake_user/preferences/username?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the updated username" do
      response = subject.update_username("fake_user", "fake_user_2")
      expect(response[:body]['username']).to eq('fake_user_2')
    end
  end

  describe "#create_user" do
    before do
      stub_post("http://localhost:3000/users?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_create_success.json"), headers: { content_type: "application/json" })
      stub_get("http://localhost:3000/users/hp.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: {"value"=>"foo", "challenge"=>"bar"}.to_json, headers: { content_type: "application/json" })
    end

    it "makes the post request" do
      subject.create_user :name => "Test User", :email => "test2@example.com", :password => "P@ssword", :username => "test2"
      expect(a_post("http://localhost:3000/users?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      response = subject.create_user :name => "Test User", :email => "test2@example.com", :password => "P@ssword", :username => "test2"
      expect(response).to be_a Hash
      expect(response['success']).to be_truthy
    end
  end

  describe "#activate_user" do
    before do
      stub_put("http://localhost:3000/admin/users/15/activate?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_activate_success.json"), headers: { content_type: "application/json" })
    end

    it "makes the put request" do
      subject.activate(15)
      expect(a_put("http://localhost:3000/admin/users/15/activate?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      response = subject.activate(15)
      expect(response[:body]['success']).to eq('OK')
    end
  end

  describe "#log_out_success" do
    before do
      stub_post("http://localhost:3000/admin/users/4/log_out?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("user_log_out_success.json"), headers: { content_type: "application/json" })
    end

    it "makes a post request" do
      subject.log_out(4)
      expect(a_post("http://localhost:3000/admin/users/4/log_out?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      response = subject.log_out(4)
      expect(response).to be_a Hash
      expect(response['success']).to eq('OK')
    end
  end

  describe "#log_out_unsuccessful" do
    before do
      stub_post("http://localhost:3000/admin/users/90/log_out?api_key=test_d7fd0429940&api_username=test_user").to_return(status: 404, headers: { content_type: "application/json" })
    end

    it "Raises API Error" do
      expect{subject.log_out(90)}.to raise_error DiscourseApi::Error
    end
  end
end
