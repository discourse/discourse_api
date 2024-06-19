# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Badges do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#badges" do
    before do
      stub_get("#{host}/admin/badges.json").to_return(
        body: fixture("badges.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.badges
      expect(a_get("#{host}/admin/badges.json")).to have_been_made
    end

    it "returns the requested badges" do
      badges = client.badges
      expect(badges).to be_a Hash
      expect(badges["badges"]).to be_an Array
    end
  end

  describe "#user-badges" do
    before do
      stub_get("#{host}/user-badges/test_user.json").to_return(
        body: fixture("user_badges.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.user_badges("test_user")
      expect(a_get("#{host}/user-badges/test_user.json")).to have_been_made
    end

    it "returns the requested user badges" do
      badges = client.user_badges("test_user")
      expect(badges).to be_an Array
      expect(badges.first).to be_a Hash
      expect(badges.first).to have_key("badge_type_id")
    end
  end
end
