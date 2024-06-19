# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Categories do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#categories" do
    before do
      stub_get("#{host}/categories.json").to_return(
        body: fixture("categories.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.categories
      expect(a_get("#{host}/categories.json")).to have_been_made
    end

    it "returns the requested categories" do
      categories = client.categories
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end

    it "returns the requested categories with hash arg" do
      categories = client.categories({})
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end
  end

  describe "#categories_full" do
    before do
      stub_get("#{host}/categories.json").to_return(
        body: fixture("categories.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.categories
      expect(a_get("#{host}/categories.json")).to have_been_made
    end

    it "returns the entire categories response" do
      categories = client.categories_full
      expect(categories).to be_a Hash
      expect(categories).to have_key "category_list"
      expect(categories).to have_key "featured_users"
    end
  end

  describe "#category_latest_topics" do
    before do
      stub_get("#{host}/c/category-slug/l/latest.json").to_return(
        body: fixture("category_latest_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the latest topics in a category" do
      latest_topics = client.category_latest_topics(category_slug: "category-slug")
      expect(latest_topics).to be_an Array
    end
  end

  describe "#category_latest_topics_full" do
    before do
      stub_get("#{host}/c/category-slug/l/latest.json").to_return(
        body: fixture("category_latest_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the entire latest topics in a category response" do
      latest_topics = client.category_latest_topics_full(category_slug: "category-slug")
      expect(latest_topics).to be_a Hash
      expect(latest_topics).to have_key "topic_list"
      expect(latest_topics).to have_key "users"
    end
  end

  describe "#category_top_topics" do
    before do
      stub_get("#{host}/c/category-slug/l/top.json").to_return(
        body: fixture("category_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the top topics in a category" do
      topics = client.category_top_topics("category-slug")
      expect(topics).to be_an Array
    end
  end

  describe "#category_top_topics_full" do
    before do
      stub_get("#{host}/c/category-slug/l/top.json").to_return(
        body: fixture("category_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the entire top topics in a category response" do
      topics = client.category_top_topics_full("category-slug")
      expect(topics).to be_a Hash
      expect(topics).to have_key "topic_list"
      expect(topics).to have_key "users"
    end
  end

  describe "#category_new_topics" do
    before do
      stub_get("#{host}/c/category-slug/l/new.json").to_return(
        body: fixture("category_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the new topics in a category" do
      topics = client.category_new_topics("category-slug")
      expect(topics).to be_an Array
    end
  end

  describe "#category_new_topics_full" do
    before do
      stub_get("#{host}/c/category-slug/l/new.json").to_return(
        body: fixture("category_topics.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "returns the new topics in a category" do
      topics = client.category_new_topics_full("category-slug")
      expect(topics).to be_a Hash
      expect(topics).to have_key "topic_list"
      expect(topics).to have_key "users"
    end
  end

  describe "#category_new_category" do
    before do
      stub_post("#{host}/categories")
      client.create_category(
        name: "test_category",
        color: "283890",
        text_color: "FFFFFF",
        description: "This is a description",
        permissions: {
          "group_1" => 1,
          "admins" => 1,
        },
      )
    end

    it "makes a create category request" do
      expect(
        a_post("#{host}/categories").with(
          body:
            "color=283890&description=This+is+a+description&name=test_category&parent_category_id&permissions%5Badmins%5D=1&permissions%5Bgroup_1%5D=1&text_color=FFFFFF",
        ),
      ).to have_been_made
    end
  end

  describe "#reorder_categories" do
    before do
      stub_post("#{host}/categories/reorder").to_return(
        body: fixture("notification_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes a categories reordering request" do
      payload = { "1": 2, "2": 3, "3": 4, "4": 1 }
      response = client.reorder_categories(mapping: payload.to_json)
      expect(
        a_post("#{host}/categories/reorder").with(
          body: "mapping=#{CGI.escape(payload.to_json.to_s)}",
        ),
      ).to have_been_made
      expect(response["success"]).to eq("OK")
    end
  end

  describe "#category_set_user_notification" do
    before do
      stub_post("#{host}/category/1/notifications").to_return(
        body: fixture("notification_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the post request" do
      response = client.category_set_user_notification(id: 1, notification_level: 3)
      expect(a_post("#{host}/category/1/notifications")).to have_been_made
      expect(response["success"]).to eq("OK")
    end
  end

  describe "#category_set_user_notification_level" do
    before do
      stub_post("#{host}/category/1/notifications").to_return(
        body: fixture("notification_success.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "makes the post request" do
      response = client.category_set_user_notification_level(1, notification_level: 3)
      expect(
        a_post("#{host}/category/1/notifications").with(body: "notification_level=3"),
      ).to have_been_made
      expect(response["success"]).to eq("OK")
    end
  end
end
