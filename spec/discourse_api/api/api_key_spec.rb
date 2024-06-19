# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::ApiKey do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#list_api_keys" do
    before do
      url = "#{host}/admin/api/keys"
      stub_get(url).to_return(
        body: fixture("list_api_keys.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.list_api_keys
      url = "#{host}/admin/api/keys"
      expect(a_get(url)).to have_been_made
    end

    it "returns the requested api keys" do
      keys = client.list_api_keys
      expect(keys["keys"]).to be_an Array
      expect(keys["keys"].first).to be_a Hash
      expect(keys["keys"].first).to have_key("key")
    end
  end

  describe "#create_api_key" do
    before do
      url = "#{host}/admin/api/keys"
      stub_post(url).to_return(
        body: fixture("api_key.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.create_api_key(key: { username: "robin" })
      url = "#{host}/admin/api/keys"
      expect(a_post(url)).to have_been_made
    end

    it "returns the generated api key" do
      api_key = client.create_api_key(key: { username: "robin" })
      expect(api_key).to be_a Hash
      expect(api_key["key"]).to have_key("key")
    end
  end

  describe "#revoke_api_key" do
    before do
      url = "#{host}/admin/api/keys/10/revoke"
      stub_post(url).to_return(
        body: fixture("api_key.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.revoke_api_key(10)
      url = "#{host}/admin/api/keys/10/revoke"
      expect(a_post(url)).to have_been_made
    end

    it "returns the api key" do
      api_key = client.revoke_api_key(10)
      expect(api_key["key"]).to have_key("key")
    end
  end

  describe "#undo_revoke_api_key" do
    before do
      url = "#{host}/admin/api/keys/10/undo-revoke"
      stub_post(url).to_return(
        body: fixture("api_key.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.undo_revoke_api_key(10)
      url = "#{host}/admin/api/keys/10/undo-revoke"
      expect(a_post(url)).to have_been_made
    end

    it "returns the api key" do
      api_key = client.undo_revoke_api_key(10)
      expect(api_key["key"]).to have_key("key")
    end
  end

  describe "#delete_api_key" do
    before do
      url = "#{host}/admin/api/keys/10"
      stub_delete(url).to_return(
        body: '{"success": "OK"}',
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.delete_api_key(10)
      url = "#{host}/admin/api/keys/10"
      expect(a_delete(url)).to have_been_made
    end

    it "returns 200" do
      response = client.delete_api_key(10)
      expect(response["status"]).to eq(200)
    end
  end
end
