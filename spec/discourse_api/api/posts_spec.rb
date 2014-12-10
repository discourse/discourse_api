require 'spec_helper'

describe DiscourseApi::API::Posts do
  let (:client) { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#get_post" do
    before do
      stub_get("http://localhost:3000/posts/11.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("post.json"), headers: { content_type: "application/json" })
    end

    it "fetches a post" do
      the_post = client.get_post(11)
      expect(the_post).to be_a Hash
      expect(the_post['id']).to eq(11)
    end
  end

end
