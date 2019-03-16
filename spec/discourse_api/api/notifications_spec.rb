require 'spec_helper'

describe DiscourseApi::API::Notifications do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#notifications" do

    before do
      stub_get("http://localhost:3000/notifications.json").to_return(body: fixture("notifications.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.notifications
      expect(a_get("http://localhost:3000/notifications.json")).to have_been_made
    end

    it "returns the requested notifications" do
      notifications = subject.notifications
      expect(notifications).to be_an Array
      expect(notifications.first).to be_an Hash
      expect(notifications[0]['notification_type']).to eq(9)
    end
  end
end
