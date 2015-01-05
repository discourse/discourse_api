require 'spec_helper'

describe DiscourseApi::API::Groups do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#badges" do
    before do
      stub_get("http://localhost:3000/admin/badges.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("badges.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.badges
      expect(a_get("http://localhost:3000/admin/badges.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested badges" do
      badges = subject.badges
      expect(badges).to be_a Hash
      expect(badges['badges']).to be_an Array
    end
  end
end
