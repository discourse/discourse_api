require 'spec_helper'

describe DiscourseApi::API::Notifications do
  subject { DiscourseApi::Client.new("http://localhost:3000") }

  describe "#notifications" do

    before do
      stub_get("http://localhost:3000/notifications.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("notifications.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.notifications
      expect(a_get("http://localhost:3000/notifications.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested notifications" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      notifications = subject.notifications
      expect(notifications).to be_an Array
      expect(notifications.first).to be_an Hash
      expect(notifications[0]['notification_type']).to eq(9)
    end
  end
end
