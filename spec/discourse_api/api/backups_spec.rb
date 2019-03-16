require 'spec_helper'

describe DiscourseApi::API::Backups do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#backups" do
    before do
      stub_get("http://localhost:3000/admin/backups.json").to_return(body: fixture("backups.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.backups
      expect(a_get("http://localhost:3000/admin/backups.json")).to have_been_made
    end

    it "returns the requested backups" do
      backups = subject.backups
      expect(backups).to be_an Array
      expect(backups.first).to be_a Hash
      expect(backups.first).to have_key('filename')
    end
  end
end
