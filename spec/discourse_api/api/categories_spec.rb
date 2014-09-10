require 'spec_helper'

describe DiscourseApi::API::Categories do
  subject { DiscourseApi::Client.new("http://localhost:3000") }

  describe "#categories" do
    before do
      stub_get("http://localhost:3000/categories.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("categories.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.categories
      expect(a_get("http://localhost:3000/categories.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested categories" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      categories = subject.categories
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end
  end

  describe '#category_latest_topics' do
    before do
      stub_get("http://localhost:3000/category/category-slug.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("category_latest_topics.json"), headers: { content_type: "application/json" })
    end

    it "returns the latest topics in a category" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      latest_topics = subject.category_latest_topics('category-slug')
      expect(latest_topics).to be_an Array
    end
  end
end
