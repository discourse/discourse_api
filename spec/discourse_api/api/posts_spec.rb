require 'spec_helper'

describe DiscourseApi::API::Posts do
  let (:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#get_post" do
    before do
      stub_get("#{host}/posts/11.json").to_return(body: fixture("post.json"), headers: { content_type: "application/json" })
    end

    it "fetches a post" do
      the_post = client.get_post(11)
      expect(the_post).to be_a Hash
      expect(the_post['id']).to eq(11)
    end
  end

  describe "#posts" do
    before do
      stub_get("#{host}/posts.json?before=0").to_return(body: fixture("posts_latest.json"), headers: { content_type: "application/json" })
      stub_get("#{host}/posts.json?before=14").to_return(body: fixture("posts_before.json"), headers: { content_type: "application/json" })
    end

    it "fetches latest posts" do
      the_posts = client.posts()
      expect(the_posts).to be_a Hash
      expect(the_posts['latest_posts'][0]['id']).to eq(15)
    end

    it "fetches posts before 14" do
      the_posts = client.posts(before: 14)
      expect(the_posts).to be_a Hash
      expect(the_posts['latest_posts'][0]['id']).to eq(14)
    end
  end

  describe "#wikify_post" do
    before do
      stub_put("#{host}/posts/9999/wiki")
    end

    it "fails on unknown post" do
      client.wikify_post(9999)
      expect(a_put("#{host}/posts/9999/wiki")).to have_been_made
    end
  end

  describe "#delete_post" do
    before do
      stub_delete("#{host}/posts/9999.json")
    end

    it "deletes a post" do
      client.delete_post(9999)
      expect(a_delete("#{host}/posts/9999.json")).to have_been_made
    end
  end

  describe "#post_action_users" do
    before do
      stub_get("#{host}/post_action_users.json?id=11&post_action_type_id=2").to_return(body: fixture("post_action_users.json"), headers: { content_type: "application/json" })
    end

    it "fetches post_action_users" do
      post_action_users = client.post_action_users(11, 2)
      expect(post_action_users).to be_a Hash
      expect(post_action_users["post_action_users"][0]["id"]).to eq(1286)
    end
  end

end
