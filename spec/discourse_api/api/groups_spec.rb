# frozen_string_literal: true
require 'spec_helper'

describe DiscourseApi::API::Groups do
  subject { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#groups" do
    before do
      stub_get("#{host}/groups.json").to_return(body: fixture("groups.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.groups
      expect(a_get("#{host}/groups.json")).to have_been_made
    end

    it "returns the requested groups" do
      groups = subject.groups
      expect(groups).to be_an Array
      groups.each { |g| expect(g).to be_a Hash }
    end

    it "returns a single group" do
      stub_get("#{host}/groups/some-group.json").to_return(body: fixture("group.json"), headers: { content_type: "application/json" })
      group = subject.group('some-group')
      expect(group['basic_group']).to be_a Hash
    end

    it "create new groups" do
      stub_post("#{host}/admin/groups")
      subject.create_group(name: "test_group")
      params = escape_params("group[name]" => "test_group", "group[visibility_level]" => 0)
      expect(a_post("#{host}/admin/groups").
              with(body: params)
            ).to have_been_made
    end

    it "update an existing group" do
      stub_put("#{host}/groups/42")
      subject.update_group(42, name: "test_group")
      params = escape_params("group[name]" => "test_group", "group[visibility_level]" => 0)
      expect(a_put("#{host}/groups/42").
              with(body: params)
            ).to have_been_made
    end

    describe "add members" do
      before do
        stub_request(:put, "#{host}/admin/groups/123/members.json")
      end

      it "adds a single member by username" do
        subject.group_add(123, username: "sam")
        expect(a_request(:put, "#{host}/admin/groups/123/members.json").
                with(body: { usernames: "sam" })
              ).to have_been_made
      end

      it "adds an array of members by username" do
        subject.group_add(123, usernames: ["sam", "jeff"])
        expect(a_request(:put, "#{host}/admin/groups/123/members.json").
                with(body: { usernames: "sam,jeff" })
              ).to have_been_made
      end

      it "adds a single member by user_id" do
        subject.group_add(123, user_id: 456)
        expect(a_request(:put, "#{host}/admin/groups/123/members.json").
                with(body: { user_ids: "456" })
              ).to have_been_made
      end

      it "adds an array of members by user_id" do
        subject.group_add(123, user_id: [123, 456])
        expect(a_request(:put, "#{host}/admin/groups/123/members.json").
                with(body: { user_ids: "123,456" })
              ).to have_been_made
      end
    end

    describe "remove members" do
      let(:url) { "#{host}/admin/groups/123/members.json?usernames=sam" }

      before do
        stub_delete(url)
      end

      it "removes member" do
        subject.group_remove(123, username: "sam")
        expect(a_delete(url)).to have_been_made
      end
    end

    describe "add owners" do
      let(:url) { "#{host}/admin/groups/123/owners.json" }

      before do
        stub_put(url)
      end

      it "makes the member an owner" do
        subject.group_add_owners(123, usernames: "sam")
        params = escape_params("group[usernames]" => "sam")
        expect(a_request(:put, "#{host}/admin/groups/123/owners.json").
                with(body: params)
              ).to have_been_made
      end
    end

    describe "remove owners" do
      let(:url) { "#{host}/admin/groups/123/owners.json?group%5Busernames%5D=sam" }

      before do
        stub_delete(url)
      end

      it "removes the owner role from the group member" do
        subject.group_remove_owners(123, usernames: "sam")
        expect(a_delete(url)).to have_been_made
      end
    end

    describe "group members" do
      it "list members" do
        stub_get("#{host}/groups/mygroup/members.json?limit=100&offset=0").to_return(body: fixture("members_0.json"), headers: { content_type: "application/json" })
        stub_get("#{host}/groups/mygroup/members.json?limit=100&offset=100").to_return(body: fixture("members_1.json"), headers: { content_type: "application/json" })
        members = subject.group_members('mygroup')
        expect(a_get("#{host}/groups/mygroup/members.json?limit=100&offset=0")).to have_been_made
        expect(members.length).to eq(100)
        members = subject.group_members('mygroup', offset: 100)
        expect(a_get("#{host}/groups/mygroup/members.json?limit=100&offset=100")).to have_been_made
        expect(members.length).to eq(90)
      end

      context "with :all params" do
        it "lists members and owners" do
          stub_get("#{host}/groups/mygroup/members.json?limit=100&offset=0").to_return(body: fixture("members_2.json"), headers: { content_type: "application/json" })
          member_data = subject.group_members('mygroup', all: true)
          expect(a_get("#{host}/groups/mygroup/members.json?limit=100&offset=0")).to have_been_made
          expect(member_data["members"].length).to eq(100)
          expect(member_data["owners"].length).to eq(7)
          expect(member_data.keys.sort).to eq(["members", "meta", "owners"])
        end
      end
    end

    describe "group user notification level" do
      before do
        stub_post("#{host}/groups/mygroup/notifications?user_id=77&notification_level=3")
      end

      it "updates user's notification level for group" do
        subject.group_set_user_notification_level("mygroup", 77, 3)
        expect(a_post("#{host}/groups/mygroup/notifications?user_id=77&notification_level=3"))
          .to have_been_made
      end
    end

  end
end
