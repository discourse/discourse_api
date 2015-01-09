require 'spec_helper'

describe DiscourseApi::API::ApiAdmin do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#api" do
    before do
      stub_get("http://localhost:3000/admin/api.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("api.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api
      expect(a_get("http://localhost:3000/admin/api.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested api keys" do
      api = subject.api
      expect(api).to be_an Array
      expect(api.first).to be_a Hash
      expect(api.first).to have_key('key')
    end
  end
end
