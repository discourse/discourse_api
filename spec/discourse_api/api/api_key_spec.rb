require 'spec_helper'

describe DiscourseApi::API::ApiKey do
  subject {
    DiscourseApi::Client.new(
      "http://localhost:3000",
      "test_d7fd0429940",
      "test_user"
    )
  }

  describe "#api" do
    before do
      url = "http://localhost:3000/admin/api.json"
      stub_get(url).to_return(body: fixture("api.json"),
                              headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api
      url = "http://localhost:3000/admin/api.json"
      expect(a_get(url)).to have_been_made
    end

    it "returns the requested api keys" do
      api = subject.api
      expect(api).to be_an Array
      expect(api.first).to be_a Hash
      expect(api.first).to have_key('key')
    end
  end

  describe "#generate_user_api_key" do
    before do
      url = "http://localhost:3000/admin/users/2/generate_api_key.json"
      stub_post(url).to_return(body: fixture("generate_api_key.json"),
                               headers: { content_type: "application/json" })
    end

    it "returns the generated api key" do
      api_key = subject.generate_user_api_key(2)
      expect(api_key).to be_a Hash
      expect(api_key['api_key']).to have_key('key')
    end
  end

  describe "#revoke_user_api_key" do
    before do
      url = "http://localhost:3000/admin/users/2/revoke_api_key.json"
      stub_delete(url).to_return(body: "",
      headers: { content_type: "application/json" })
    end

    it "returns 200" do
      response = subject.revoke_user_api_key(2)
      expect(response['status']).to eq(200)
    end
  end

  describe "#generate_master_key" do
    before do
      url = "http://localhost:3000/admin/api/key"
      stub_post(url).to_return(body: fixture("generate_master_key.json"),
                               headers: { content_type: "application/json" })
    end

    it "returns the generated master key" do
      master_key = subject.generate_master_key
      expect(master_key).to be_a Hash
      expect(master_key['api_key']).to have_key('key')
      expect(master_key['api_key']['user']).to eq(nil)
    end
  end

  describe "#revoke_api_key" do
    before do
      url = "http://localhost:3000/admin/api/key?id=10"
      stub_delete(url).to_return(body: "",
                                 headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.revoke_api_key(10)
      url = "http://localhost:3000/admin/api/key?id=10"
      expect(a_delete(url)).to have_been_made
    end

    it "returns 200" do
      response = subject.revoke_api_key(10)
      expect(response['status']).to eq(200)
    end
  end

  describe "#regenerate_api_key" do
    before do
      url = "http://localhost:3000/admin/api/key"
      stub_put(url).to_return(body: fixture("regenerate_api_key.json"),
                                 headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.regenerate_api_key(10)
      url = "http://localhost:3000/admin/api/key"
      expect(a_put(url)).to have_been_made
    end

    it "returns the regenerated api key" do
      key = subject.regenerate_api_key(10)
      expect(key['api_key']).to have_key('key')
    end
  end
end
