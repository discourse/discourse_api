# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Users do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#user" do
    before do
      stub_get("#{host}/users/test.json").to_return(
        body: fixture("user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.user("test")
      expect(a_get("#{host}/users/test.json")).to have_been_made
    end

    it "returns the requested user" do
      user = client.user("test")
      expect(user).to be_a Hash
    end

    it "works with optional params" do
      user = client.user("test", {})
      expect(user).to be_a Hash
    end
  end

  describe "#user_sso" do
    before do
      stub_get("#{host}/admin/users/15.json").to_return(
        body: fixture("admin_user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.user_sso(15)
      expect(a_get("#{host}/admin/users/15.json")).to have_been_made
    end

    it "has single_sign_on_record" do
      user_sso = client.user_sso(15)
      expect(user_sso).to be_a Hash
      expect(user_sso).to have_key("external_id")
    end
  end

  describe "#update_avatar" do
    before do
      stub_post("#{host}/uploads").to_return(
        body: fixture("upload_avatar.json"),
        headers: {
          content_type: "application/json",
        },
      )
      stub_put("#{host}/u/test_user/preferences/avatar/pick").to_return(
        body: fixture("user_update_avatar_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "uploads an image" do
      sam =
        "https://meta-discourse.global.ssl.fastly.net/user_avatar/meta.discourse.org/sam/120/5243.png"
      args = { url: sam }
      response = client.update_avatar("test_user", args)
      expect(response[:body]["success"]).to eq("OK")
    end
  end

  describe "#update_email" do
    before do
      stub_put("#{host}/u/fake_user/preferences/email").to_return(
        body: fixture("user_update_user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      client.update_email("fake_user", "fake_user_2@example.com")
      expect(a_put("#{host}/u/fake_user/preferences/email")).to have_been_made
    end

    it "returns success" do
      response = client.update_email("fake_user", "fake_user_2@example.com")
      expect(response[:body]["success"]).to be_truthy
    end
  end

  describe "#update_user" do
    before do
      stub_put("#{host}/u/fake_user").to_return(
        body: fixture("user_update_user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      client.api_key = "test_d7fd0429940"
      client.api_username = "test_user"
      client.update_user("fake_user", name: "Fake User 2")
      expect(a_put("#{host}/u/fake_user")).to have_been_made
    end

    it "returns success" do
      client.api_key = "test_d7fd0429940"
      client.api_username = "test_user"
      response = client.update_user("fake_user", name: "Fake User 2")
      expect(response[:body]["success"]).to be_truthy
    end
  end

  describe "#update_username" do
    before do
      stub_put("#{host}/u/fake_user/preferences/username").to_return(
        body: fixture("user_update_username.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      client.update_username("fake_user", "fake_user_2")
      expect(a_put("#{host}/u/fake_user/preferences/username")).to have_been_made
    end

    it "returns the updated username" do
      response = client.update_username("fake_user", "fake_user_2")
      expect(response[:body]["username"]).to eq("fake_user_2")
    end
  end

  describe "#create_user" do
    before do
      stub_post("#{host}/users").to_return(
        body: fixture("user_create_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the post request" do
      client.create_user name: "Test User",
                         email: "test2@example.com",
                         password: "P@ssword",
                         username: "test2"
      expect(a_post("#{host}/users")).to have_been_made
    end

    it "returns success" do
      response =
        client.create_user name: "Test User",
                           email: "test2@example.com",
                           password: "P@ssword",
                           username: "test2"
      expect(response).to be_a Hash
      expect(response["success"]).to be_truthy
    end
  end

  describe "#activate_user" do
    before do
      stub_put("#{host}/admin/users/15/activate").to_return(
        body: fixture("user_activate_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the put request" do
      client.activate(15)
      expect(a_put("#{host}/admin/users/15/activate")).to have_been_made
    end

    it "returns success" do
      response = client.activate(15)
      expect(response[:body]["success"]).to eq("OK")
    end
  end

  describe "#log_out_success" do
    before do
      stub_post("#{host}/admin/users/4/log_out").to_return(
        body: fixture("user_log_out_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes a post request" do
      client.log_out(4)
      expect(a_post("#{host}/admin/users/4/log_out")).to have_been_made
    end

    it "returns success" do
      response = client.log_out(4)
      expect(response).to be_a Hash
      expect(response["success"]).to eq("OK")
    end
  end

  describe "#log_out_unsuccessful" do
    before do
      stub_post("#{host}/admin/users/90/log_out").to_return(
        status: 404,
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "Raises API Error" do
      expect { client.log_out(90) }.to raise_error DiscourseApi::NotFoundError
    end
  end

  describe "#list_users" do
    before do
      stub_get("#{host}/admin/users/list/active.json").to_return(
        body: fixture("user_list.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.list_users("active")
      expect(a_get("#{host}/admin/users/list/active.json")).to have_been_made
    end

    it "returns the requested users" do
      users = client.list_users("active")
      expect(users).to be_an Array
      expect(users.first).to be_a Hash
    end
  end

  describe "#update_trust_level" do
    before do
      url = "#{host}/admin/users/2/trust_level"
      stub_put(url).to_return(
        body: fixture("update_trust_level.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the correct put request" do
      params = { level: 2 }
      client.update_trust_level(2, params)
      url = "#{host}/admin/users/2/trust_level"
      expect(a_put(url)).to have_been_made
    end

    it "updates the trust_level" do
      params = { level: 2 }
      admin_user = client.update_trust_level(2, params)
      expect(admin_user).to be_a Hash
      expect(admin_user["admin_user"]).to have_key("trust_level")
    end
  end

  describe "#grant admin" do
    before do
      url = "#{host}/admin/users/11/grant_admin"
      stub_put(url).to_return(
        body: fixture("user_grant_admin.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the correct put request" do
      client.grant_admin(11)
      url = "#{host}/admin/users/11/grant_admin"
      expect(a_put(url)).to have_been_made
    end

    it "makes the user an admin" do
      result = client.grant_admin(11)
      expect(result).to be_a Hash
      expect(result["admin_user"]["admin"]).to eq(true)
    end
  end

  describe "#grant moderation" do
    before do
      url = "#{host}/admin/users/11/grant_moderation"
      stub_put(url).to_return(
        body: fixture("user_grant_moderator.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the correct put request" do
      client.grant_moderation(11)
      url = "#{host}/admin/users/11/grant_moderation"
      expect(a_put(url)).to have_been_made
    end

    it "makes the user a moderator" do
      result = client.grant_moderation(11)
      expect(result).to be_a Hash
      expect(result["admin_user"]["moderator"]).to eq(true)
    end
  end

  describe "#revoke moderation" do
    before do
      url = "#{host}/admin/users/11/revoke_moderation"
      stub_put(url).to_return(body: "", status: 200)
    end

    it "makes the correct put request" do
      result = client.revoke_moderation(11)
      url = "#{host}/admin/users/11/revoke_moderation"
      expect(a_put(url)).to have_been_made
      expect(result.status).to eq(200)
    end
  end

  describe "#by_external_id" do
    before do
      stub_get("#{host}/users/by-external/1").to_return(
        body: fixture("user.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.by_external_id(1)
      expect(a_get("#{host}/users/by-external/1")).to have_been_made
    end

    it "returns the requested user" do
      user = client.by_external_id(1)
      expect(user["id"]).to eq 1
    end
  end

  describe "#suspend" do
    before do
      url = "#{host}/admin/users/11/suspend"
      stub_put(url).to_return(body: "", status: 200)
    end

    it "makes the correct put request" do
      result = client.suspend(11, "2030-01-01", "no reason")
      url = "#{host}/admin/users/11/suspend"
      expect(a_put(url)).to have_been_made
      expect(result.status).to eq(200)
    end
  end

  describe "#unsuspend" do
    before do
      url = "#{host}/admin/users/11/unsuspend"
      stub_put(url).to_return(body: "", status: 200)
    end

    it "makes the correct put request" do
      result = client.unsuspend(11)
      url = "#{host}/admin/users/11/unsuspend"
      expect(a_put(url)).to have_been_made
      expect(result.status).to eq(200)
    end
  end

  describe "#anonymize" do
    before do
      url = "#{host}/admin/users/11/anonymize"
      stub_put(url).to_return(body: "", status: 200)
    end

    it "makes the correct put request" do
      result = client.anonymize(11)
      url = "#{host}/admin/users/11/anonymize"
      expect(a_put(url)).to have_been_made
      expect(result.status).to eq(200)
    end
  end

  describe "#delete_user" do
    before do
      url = "#{host}/admin/users/11.json?delete_posts=true"
      stub_delete(url).to_return(body: '{"deleted": true}', status: 200)
    end

    it "makes the correct delete request" do
      result = client.delete_user(11, true)
      url = "#{host}/admin/users/11.json?delete_posts=true"
      expect(a_delete(url)).to have_been_made
      expect(result.body).to eq('{"deleted": true}')
      expect(result.status).to eq(200)
    end
  end

  describe "#check_username" do
    let(:url) { "#{host}/users/check_username.json?username=sparrow" }
    let(:body) { '{"available":false,"suggestion":"sparrow1"}' }

    before { stub_get(url).to_return(body: body, headers: { content_type: "application/json" }) }

    it "requests the correct resource" do
      client.check_username("sparrow")
      expect(a_get(url)).to have_been_made
    end

    it "returns the result" do
      result = client.check_username("sparrow")
      expect(result["available"]).to eq false
    end

    context "when non-URI characters are used" do
      let(:url) { "#{host}/users/check_username.json?username=1_%5B4%5D%21+%40the%24%23%3F" }
      let(:body) { '{"errors":["must only include numbers, letters, dashes, and underscores"]}' }

      it "escapes them" do
        client.check_username("1_[4]! @the$#?")
        expect(a_get(url)).to have_been_made
      end

      it "returns the result" do
        result = client.check_username("1_[4]! @the$#?")
        expect(
          result["errors"].first,
        ).to eq "must only include numbers, letters, dashes, and underscores"
      end
    end
  end

  describe "#deactivate" do
    before { stub_put("#{host}/admin/users/15/deactivate").to_return(body: nil) }

    it "makes the put request" do
      client.deactivate(15)
      expect(a_put("#{host}/admin/users/15/deactivate")).to have_been_made
    end

    it "returns success" do
      response = client.deactivate(15)
      expect(response.status).to eq(200)
    end
  end
end
