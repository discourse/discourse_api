require 'spec_helper'

describe DiscourseApi::API::PrivateMessages do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#private_messages" do
    before do
      stub_get("http://localhost:3000/topics/private-messages/test_user.json").to_return(body: fixture("private_messages.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.private_messages('test_user')
      expect(a_get("http://localhost:3000/topics/private-messages/test_user.json")).to have_been_made
    end

    it "returns the requested private messages" do
      private_messages = subject.private_messages('test_user')
      expect(private_messages).to be_an Array
    end
  end

  describe "#sent_private_messages" do
    before do
      stub_get("http://localhost:3000/topics/private-messages-sent/test_user.json").to_return(body: fixture("private_messages.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.sent_private_messages('test_user')
      expect(a_get("http://localhost:3000/topics/private-messages-sent/test_user.json")).to have_been_made
    end

    it "returns the requested sent private messages" do
      private_messages = subject.sent_private_messages('test_user')
      expect(private_messages).to be_an Array
    end
  end

  describe '#create_private_message' do
    before do
      stub_post("http://localhost:3000/posts")
      subject.create_private_message(
        title: "Confidential: Hello World!",
        raw: "This is the raw markdown for my private message",
        target_usernames: "user1,user2"
      )
    end

    it "makes a create private message request" do
      expect(a_post("http://localhost:3000/posts").with(body:
          'archetype=private_message&raw=This+is+the+raw+markdown+for+my+private+message&target_usernames=user1%2Cuser2&title=Confidential%3A+Hello+World%21')
        ).to have_been_made
    end
  end
end
