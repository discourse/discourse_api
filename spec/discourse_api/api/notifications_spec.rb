# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Notifications do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#notifications" do
    before do
      stub_get("#{host}/notifications.json").to_return(
        body: fixture("notifications.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.notifications
      expect(a_get("#{host}/notifications.json")).to have_been_made
    end

    it "returns the requested notifications" do
      notifications = client.notifications
      expect(notifications).to be_an Array
      expect(notifications.first).to be_an Hash
      expect(notifications[0]["notification_type"]).to eq(9)
    end
  end
end
