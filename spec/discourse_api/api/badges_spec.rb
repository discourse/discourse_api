require 'spec_helper'

describe DiscourseApi::API::Badges do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#badges" do
    before do
      stub_get("http://localhost:3000/admin/badges.json").to_return(body: fixture("badges.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.badges
      expect(a_get("http://localhost:3000/admin/badges.json")).to have_been_made
    end

    it "returns the requested badges" do
      badges = subject.badges
      expect(badges).to be_a Hash
      expect(badges['badges']).to be_an Array
    end
  end

  describe "#user_badges" do
    before do
      stub_get("http://localhost:3000/users/test_user/activity/badges.json").to_return(body: fixture("user_badges.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.user_badges('test_user')
      expect(a_get("http://localhost:3000/users/test_user/activity/badges.json")).to have_been_made
    end

    it "returns the requested user badges" do
      badges = subject.user_badges('test_user')
      expect(badges).to be_an Array
      expect(badges.first).to be_a Hash
      expect(badges.first).to have_key('badge_type_id')
    end
  end
end
