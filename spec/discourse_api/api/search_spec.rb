require 'spec_helper'

describe DiscourseApi::API::Search do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#search" do
    before do
      stub_get("http://localhost:3000/search/query").with(query: { term: "test"} ).to_return(body: fixture("search.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.search("test")
      expect(a_get("http://localhost:3000/search/query").with(query: { term: "test"} )).to have_been_made
    end

    it "returns the requested search" do
      results = subject.search("test")
      expect(results).to be_an Array
      expect(results.first).to be_a Hash
    end

    it "raises an ArgumentError for nil" do
      expect { subject.search(nil) }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError for empty string" do
      expect { subject.search('') }.to raise_error(ArgumentError)
    end
  end
end
