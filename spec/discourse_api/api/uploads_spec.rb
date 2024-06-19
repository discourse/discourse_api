# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::API::Uploads do
  subject(:client) { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  describe "#upload_file" do
    before do
      stub_post("#{host}/uploads").to_return(
        body: fixture("upload_file.json"),
        headers: {
          content_type: "application/json",
        },
      )
    end

    it "uploads an image via URL" do
      image =
        "https://meta-discourse.global.ssl.fastly.net/user_avatar/meta.discourse.org/sam/120/5243.png"
      args = { url: image }
      response = client.upload_file(args)
      expect(response["url"]).to eq(
        "/uploads/default/original/1X/417e624d2453925e6c68748b9aa67637c284b5aa.jpg",
      )
    end

    it "uploads a file" do
      file = Faraday::UploadIO.new("spec/fixtures/upload_file.json", "application/json")
      args = { file: file }
      response = client.upload_file(args)
      expect(response["url"]).to eq(
        "/uploads/default/original/1X/417e624d2453925e6c68748b9aa67637c284b5aa.jpg",
      )
    end
  end
end
