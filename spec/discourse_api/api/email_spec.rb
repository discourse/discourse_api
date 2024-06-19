# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Email do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#email_settings" do
    before do
      stub_get("#{host}/admin/email.json").to_return(
        body: fixture("email_settings.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.email_settings
      expect(a_get("#{host}/admin/email.json")).to have_been_made
    end

    it "returns the requested settings" do
      settings = client.email_settings
      expect(settings).to be_a Hash
      expect(settings).to have_key("delivery_method")
      expect(settings).to have_key("settings")
    end
  end

  describe "#list_email_all" do
    before do
      stub_get("#{host}/admin/email/all.json").to_return(
        body: fixture("email_list_all.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.list_email("all")
      expect(a_get("#{host}/admin/email/all.json")).to have_been_made
    end

    it "returns all email" do
      all_email = client.list_email("all")
      expect(all_email).to be_an Array
    end
  end
end
