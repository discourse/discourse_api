require 'spec_helper'

describe DiscourseApi::API::Email do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#email_settings" do
    before do
      stub_get("http://localhost:3000/admin/email.json").to_return(body: fixture("email_settings.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.email_settings
      expect(a_get("http://localhost:3000/admin/email.json")).to have_been_made
    end

    it "returns the requested settings" do
      settings = subject.email_settings
      expect(settings).to be_a Hash
      expect(settings).to have_key('delivery_method')
      expect(settings).to have_key('settings')
    end
  end

  describe "#list_email_all" do
    before do
      stub_get("http://localhost:3000/admin/email/all.json").to_return(body: fixture("email_list_all.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.list_email('all')
      expect(a_get("http://localhost:3000/admin/email/all.json")).to have_been_made
    end

    it "returns all email" do
      all_email = subject.list_email('all')
      expect(all_email).to be_an Array
    end
  end
end
