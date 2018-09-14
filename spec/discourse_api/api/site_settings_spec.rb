require 'spec_helper'

describe DiscourseApi::API::SiteSettings do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#site_setting_update" do
    before do
      stub_put("http://localhost:3000/admin/site_settings/foo?api_key=test_d7fd0429940&api_username=test_user")
      subject.site_setting_update(name: "foo", value: "bar")
    end

    it "makes a site_settings_update request" do
      expect(a_put("http://localhost:3000/admin/site_settings/foo?api_key=test_d7fd0429940&api_username=test_user")
             .with(body: "foo=bar")).to have_been_made
    end
  end
end
