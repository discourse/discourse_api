require 'spec_helper'

describe DiscourseApi::API::Email do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#email_settings" do
    before do
      stub_get("http://localhost:3000/admin/email.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("email_settings.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.email_settings
      expect(a_get("http://localhost:3000/admin/email.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested settings" do
      settings = subject.email_settings
      expect(settings).to be_a Hash
      expect(settings).to have_key('delivery_method')
      expect(settings).to have_key('settings')
    end
  end
end
