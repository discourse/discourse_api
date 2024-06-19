# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Search do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#search" do
    before do
      stub_get("#{host}/search").with(query: { q: "test" }).to_return(
        body: fixture("search.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "requests the correct resource" do
      client.search("test")
      expect(a_get("#{host}/search").with(query: { q: "test" })).to have_been_made
    end

    it "returns the requested search" do
      results = client.search("test")
      expect(results).to be_an Array
      expect(results.first).to be_a Hash
    end

    it "raises an ArgumentError for nil" do
      expect { client.search(nil) }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError for empty string" do
      expect { client.search("") }.to raise_error(ArgumentError)
    end
  end
end
