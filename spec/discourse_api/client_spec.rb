require 'spec_helper'

describe DiscourseApi::Client do
  subject { DiscourseApi::Client.new('http://localhost:3000') }

  describe ".new" do
    it "requires a host argument" do
      expect { DiscourseApi::Client.new }.to raise_error ArgumentError
    end

    it "defaults api key to nil" do
      expect(subject.api_key).to be_nil
    end

    it "defaults api username to nil" do
      expect(subject.api_username).to be_nil
    end

    it "accepts an api key argument" do
      client = DiscourseApi::Client.new('http://localhost:3000', 'test')
      expect(client.api_key).to eq('test')
    end

    it "accepts an api username argument" do
      client = DiscourseApi::Client.new('http://localhost:3000', 'test', 'test_user')
      expect(client.api_username).to eq('test_user')
    end
  end

  describe "#api_key" do
    it "is publically accessible" do
      subject.api_key = "test_d7fd0429940"
      expect(subject.api_key).to eq("test_d7fd0429940")
    end
  end

  describe "#api_username" do
    it "is publically accessible" do
      subject.api_username = "test_user"
      expect(subject.api_username).to eq("test_user")
    end
  end

  describe "#host" do
    it "is publically readable" do
      expect(subject.host).to eq("http://localhost:3000")
    end

    it "is not publically writeable" do
      expect(subject).not_to respond_to(:host=)
    end
  end

  describe "#connection" do
    it "looks like a Faraday connection" do
      expect(subject.send(:connection)).to respond_to :run_request
    end

    it "memorizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq(c2.object_id)
    end
  end

  describe "#delete" do
    before do
      stub_delete("http://localhost:3000/test/delete").with(query: { deleted: "object" })
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
    end

    it "allows custom delete requests" do
      subject.delete("/test/delete", { deleted: "object" })
      expect(a_delete("http://localhost:3000/test/delete").with(query: { deleted: "object" })).to have_been_made
    end

    context 'when using a host with a subdirectory' do
      subject { DiscourseApi::Client.new('http://localhost:3000/forum') }

      before do
        stub_delete("http://localhost:3000/forum/test/delete").with(query: { deleted: "object" })
      end

      it "allows custom delete requests" do
        subject.delete("/test/delete", { deleted: "object" })
        expect(a_delete("http://localhost:3000/forum/test/delete").with(query: { deleted: "object" })).to have_been_made
      end
    end
  end

  describe "#post" do
    before do
      stub_post("http://localhost:3000/test/post").with(body: { created: "object"})
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
    end

    it "allows custom post requests" do
      subject.post("/test/post", { created: "object" })
      expect(a_post("http://localhost:3000/test/post").with(body: { created: "object"})).to have_been_made
    end

    context 'when using a host with a subdirectory' do
      subject { DiscourseApi::Client.new('http://localhost:3000/forum') }

      before do
        stub_post("http://localhost:3000/forum/test/post").with(body: { created: "object"})
      end

      it "allows custom post requests" do
        subject.post("/test/post", { created: "object" })
        expect(a_post("http://localhost:3000/forum/test/post").with(body: { created: "object"})).to have_been_made
      end
    end
  end

  describe "#put" do
    before do
      stub_put("http://localhost:3000/test/put").with(body: { updated: "object" })
      subject.api_key = 'test_d7fd0429940'
      subject.api_username = 'test_user'
    end

    it "allows custom put requests" do
      subject.put("/test/put", { updated: "object" })
      expect(a_put("http://localhost:3000/test/put").with(body: { updated: "object" })).to have_been_made
    end

    context 'when using a host with a subdirectory' do
      subject { DiscourseApi::Client.new('http://localhost:3000/forum') }

      before do
        stub_put("http://localhost:3000/forum/test/put").with(body: { updated: "object" })
      end

      it "allows custom post requests" do
        subject.put("/test/put", { updated: "object" })
        expect(a_put("http://localhost:3000/forum/test/put").with(body: { updated: "object" })).to have_been_made
      end
    end
  end

  describe "#request" do
    it "catches 500 errors" do
      connection = instance_double(Faraday::Connection)
      allow(connection).to receive(:get).and_return(OpenStruct.new(env: { body: 'error page html' }, status: 500))
      allow(subject).to receive(:connection).and_return(connection)
      expect{subject.send(:request, :get, "/test")}.to raise_error DiscourseApi::Error
    end

    it "catches Faraday errors" do
      allow(subject).to receive(:connection).and_raise(Faraday::Error::ClientError.new("BOOM!"))
      expect{subject.send(:request, :get, "/test")}.to raise_error DiscourseApi::Error
    end

    it "catches JSON::ParserError errors" do
      allow(subject).to receive(:connection).and_raise(JSON::ParserError.new("unexpected token"))
      expect{subject.send(:request, :get, "/test")}.to raise_error DiscourseApi::Error
    end
  end
end
