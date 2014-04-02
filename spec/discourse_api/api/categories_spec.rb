require 'spec_helper'

describe DiscourseApi::API::Categories do
  subject { DiscourseApi::Client.new("http://localhost") }

  describe "#categories" do
    before do
      stub_get("http://localhost/categories.json?api_key&api_username").to_return(body: fixture("categories.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.categories
      expect(a_get("http://localhost/categories.json?api_key&api_username")).to have_been_made
    end

    it "returns the requested categories" do
      categories = subject.categories
      expect(categories).to be_an Array
      expect(categories.first).to be_a Hash
    end
  end
end