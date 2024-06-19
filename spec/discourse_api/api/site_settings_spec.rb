# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::SiteSettings do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#site_setting_update" do
    before do
      stub_put("#{host}/admin/site_settings/foo")
      client.site_setting_update(name: "foo", value: "bar")
    end

    it "makes a site_settings_update request" do
      expect(a_put("#{host}/admin/site_settings/foo").with(body: "foo=bar")).to have_been_made
    end
  end
end
