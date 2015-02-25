require 'spec_helper'

describe DiscourseApi::API::Groups do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#groups" do
    before do
      stub_get("http://localhost:3000/admin/groups.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("groups.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.groups
      expect(a_get("http://localhost:3000/admin/groups.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested groups" do
      groups = subject.groups
      expect(groups).to be_an Array
      groups.each { |g| expect(g).to be_a Hash }
    end

    it "create new groups" do
      stub_post("http://localhost:3000/admin/groups?api_key=test_d7fd0429940&api_username=test_user")
      subject.create_group(name: "test_group")
      expect(a_post("http://localhost:3000/admin/groups?api_key=test_d7fd0429940&api_username=test_user").
              with(body: {name: "test_group", visible: "true"})
            ).to have_been_made
    end

    it "adds members" do
      stub_request(:patch, "http://localhost:3000/admin/groups/123?api_key=test_d7fd0429940&api_username=test_user")
      subject.group_add(123, "sam")
      expect(a_request(:patch, "http://localhost:3000/admin/groups/123?api_key=test_d7fd0429940&api_username=test_user").
              with(body: {changes: {add: [ "sam" ]}})
            ).to have_been_made
    end

    it "removes members" do
      stub_request(:patch, "http://localhost:3000/admin/groups/123?api_key=test_d7fd0429940&api_username=test_user")
      subject.group_remove(123, "sam")
      expect(a_request(:patch, "http://localhost:3000/admin/groups/123?api_key=test_d7fd0429940&api_username=test_user").
              with(body: {changes: {delete: [ "sam" ]}})
            ).to have_been_made
    end
  end
end
