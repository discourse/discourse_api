require 'spec_helper'

describe DiscourseApi::API::Groups do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#groups" do
    before do
      stub_get("http://localhost:3000/groups.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("groups.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.groups
      expect(a_get("http://localhost:3000/groups.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested groups" do
      groups = subject.groups
      expect(groups).to be_an Array
      groups.each { |g| expect(g).to be_a Hash }
    end

    it "returns a single group" do
      stub_get("http://localhost:3000/groups/some-group.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("group.json"), headers: { content_type: "application/json" })
      group = subject.group('some-group')
      expect(group['basic_group']).to be_a Hash
    end

    it "create new groups" do
      stub_post("http://localhost:3000/admin/groups?api_key=test_d7fd0429940&api_username=test_user")
      subject.create_group(name: "test_group")
      params = escape_params("group[name]" => "test_group", "group[visibility_level]" => 0)
      expect(a_post("http://localhost:3000/admin/groups?api_key=test_d7fd0429940&api_username=test_user").
              with(body: params)
            ).to have_been_made
    end

    it "update an existing group" do
      stub_put("http://localhost:3000/groups/42?api_key=test_d7fd0429940&api_username=test_user")
      subject.update_group(42, name: "test_group")
      params = escape_params("group[name]" => "test_group", "group[visibility_level]" => 0)
      expect(a_put("http://localhost:3000/groups/42?api_key=test_d7fd0429940&api_username=test_user").
              with(body: params)
            ).to have_been_made
    end

    describe "add members" do
      before do
        stub_request(:put, "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user")
      end

      it "adds a single member by username" do
        subject.group_add(123, username: "sam")
        expect(a_request(:put, "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user").
                with(body: {usernames: "sam"})
              ).to have_been_made
      end

      it "adds an array of members by username" do
        subject.group_add(123, usernames: ["sam", "jeff"])
        expect(a_request(:put, "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user").
                with(body: {usernames: "sam,jeff"})
              ).to have_been_made
      end

      it "adds a single member by user_id" do
        subject.group_add(123, user_id: 456)
        expect(a_request(:put, "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user").
                with(body: {user_ids: "456"})
              ).to have_been_made
      end

      it "adds an array of members by user_id" do
        subject.group_add(123, user_id: [123, 456])
        expect(a_request(:put, "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user").
                with(body: {user_ids: "123,456"})
              ).to have_been_made
      end
    end

    describe "remove members" do
      let(:url) { "http://localhost:3000/admin/groups/123/members.json?api_key=test_d7fd0429940&api_username=test_user&usernames=sam" }

      before do
        stub_delete(url)
      end

      it "removes member" do
        subject.group_remove(123, username: "sam")
        expect(a_delete(url)).to have_been_made
      end
    end

    describe "group members" do
      before do
        stub_get("http://localhost:3000/groups/mygroup/members.json?api_key=test_d7fd0429940&api_username=test_user&limit=100&offset=0").to_return(body: fixture("members_0.json"), headers: { content_type: "application/json" })
        stub_get("http://localhost:3000/groups/mygroup/members.json?api_key=test_d7fd0429940&api_username=test_user&limit=100&offset=100").to_return(body: fixture("members_1.json"), headers: { content_type: "application/json" })
      end

      it "list members" do
        members = subject.group_members('mygroup')
        expect(a_get("http://localhost:3000/groups/mygroup/members.json?api_key=test_d7fd0429940&api_username=test_user&limit=100&offset=0")).to have_been_made
        expect(members.length).to eq(100)
        members = subject.group_members('mygroup', offset: 100)
        expect(a_get("http://localhost:3000/groups/mygroup/members.json?api_key=test_d7fd0429940&api_username=test_user&limit=100&offset=100")).to have_been_made
        expect(members.length).to eq(90)
      end
    end


  end
end
