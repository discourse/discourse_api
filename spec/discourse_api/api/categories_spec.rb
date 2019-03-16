require 'spec_helper'

describe DiscourseApi::API::Categories do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#categories" do
    before do
      stub_get("http://localhost:3000/categories.json")
        .to_return(body: fixture("categories.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.categories
      expect(a_get("http://localhost:3000/categories.json")).to have_been_made
    end

    it "returns the requested categories" do
      categories = subject.categories
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end

    it "returns the requested categories with hash arg" do
      categories = subject.categories({})
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end
  end

  describe '#category_latest_topics' do
    before do
      stub_get("http://localhost:3000/c/category-slug/l/latest.json")
        .to_return(body: fixture("category_latest_topics.json"), headers: { content_type: "application/json" })
    end

    it "returns the latest topics in a category" do
      latest_topics = subject.category_latest_topics(category_slug: 'category-slug')
      expect(latest_topics).to be_an Array
    end
  end

  describe '#category_top_topics' do
    before do
      stub_get("http://localhost:3000/c/category-slug/l/top.json")
      .to_return(
        body: fixture("category_topics.json"), 
        headers: { content_type: "application/json" }
      )
    end

    it "returns the top topics in a category" do
      topics = subject.category_top_topics('category-slug')
      expect(topics).to be_an Array
    end
  end

  describe '#category_new_topics' do
    before do
      stub_get("http://localhost:3000/c/category-slug/l/new.json")
      .to_return(
        body: fixture("category_topics.json"), 
        headers: { content_type: "application/json" }
      )
    end

    it "returns the new topics in a category" do
      topics = subject.category_new_topics('category-slug')
      expect(topics).to be_an Array
    end
  end

  describe '#category_new_category' do
    before do
      stub_post("http://localhost:3000/categories")
      subject.create_category(name: "test_category", color: "283890", text_color: "FFFFFF",
                              description: "This is a description",
                              permissions: {"group_1" => 1, "admins" => 1})
    end
    
    it "makes a create category request" do
      expect(a_post("http://localhost:3000/categories").with(body: 
          "color=283890&description=This+is+a+description&name=test_category&parent_category_id&permissions%5Badmins%5D=1&permissions%5Bgroup_1%5D=1&text_color=FFFFFF")
        ).to have_been_made
    end
  end  

end
