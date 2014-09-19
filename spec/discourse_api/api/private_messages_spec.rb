require 'spec_helper'

describe DiscourseApi::API::PrivateMessages do
  subject { DiscourseApi::Client.new("http://localhost:3000") }

  describe "#private_messages" do
    before do
      stub_get("http://localhost:3000/topics/private-messages/test_user.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("private_messages.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      subject.private_messages('test_user')
      expect(a_get("http://localhost:3000/topics/private-messages/test_user.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested private messages" do
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
      private_messages = subject.private_messages('test_user')
      expect(private_messages).to be_an Array
    end
  end

end
