# frozen_string_literal: true
require "spec_helper"

describe DiscourseApi::Client do
  subject(:client) { DiscourseApi::Client.new(host) }

  describe ".new" do
    it "requires a host argument" do
      expect { DiscourseApi::Client.new }.to raise_error ArgumentError
    end

    it "defaults api key to nil" do
      expect(client.api_key).to be_nil
    end

    it "defaults api username to nil" do
      expect(client.api_username).to be_nil
    end

    it "accepts an api key argument" do
      client = DiscourseApi::Client.new(host, "test")
      expect(client.api_key).to eq("test")
    end

    it "accepts an api username argument" do
      client = DiscourseApi::Client.new(host, "test", "test_user")
      expect(client.api_username).to eq("test_user")
    end
  end

  describe "#timeout" do
    context "with a custom timeout" do
      it "is set to Faraday connection" do
        expect(client.send(:connection).options.timeout).to eq(30)
      end
    end

    context "with the default timeout" do
      it "is set to Faraday connection" do
        client.timeout = 25
        expect(client.send(:connection).options.timeout).to eq(25)
      end
    end

    it "raises DiscourseApi::Timeout" do
      stub_get("#{host}/t/1.json").to_timeout

      expect { client.topic(1) }.to raise_error(DiscourseApi::Timeout)
    end
  end

  describe "#api_key" do
    it "is publicly accessible" do
      client.api_key = "test_d7fd0429940"
      expect(client.api_key).to eq("test_d7fd0429940")
    end
  end

  describe "#api_username" do
    it "is publicly accessible" do
      client.api_username = "test_user"
      expect(client.api_username).to eq("test_user")
    end
  end

  describe "#host" do
    it "is publicly readable" do
      expect(client.host).to eq("#{host}")
    end

    it "is not publicly writeable" do
      expect(client).not_to respond_to(:host=)
    end
  end

  describe "#connection" do
    it "looks like a Faraday connection" do
      expect(client.send(:connection)).to respond_to :run_request
    end

    it "memorizes the connection" do
      c1, c2 = client.send(:connection), client.send(:connection)
      expect(c1.object_id).to eq(c2.object_id)
    end
  end

  describe "#delete" do
    before do
      stub_delete("#{host}/test/delete").with(query: { deleted: "object" })
      client.api_key = "test_d7fd0429940"
      client.api_username = "test_user"
    end

    it "allows custom delete requests" do
      client.delete("/test/delete", { deleted: "object" })
      expect(a_delete("#{host}/test/delete").with(query: { deleted: "object" })).to have_been_made
    end

    context "when using a host with a subdirectory" do
      subject(:client) { DiscourseApi::Client.new("#{host}/forum") }

      before { stub_delete("#{host}/forum/test/delete").with(query: { deleted: "object" }) }

      it "allows custom delete requests" do
        client.delete("/test/delete", { deleted: "object" })
        expect(
          a_delete("#{host}/forum/test/delete").with(query: { deleted: "object" }),
        ).to have_been_made
      end
    end
  end

  describe "#post" do
    before do
      stub_post("#{host}/test/post").with(body: { created: "object" })
      client.api_key = "test_d7fd0429940"
      client.api_username = "test_user"
    end

    it "allows custom post requests" do
      client.post("/test/post", { created: "object" })
      expect(a_post("#{host}/test/post").with(body: { created: "object" })).to have_been_made
    end

    context "when using a host with a subdirectory" do
      subject(:client) { DiscourseApi::Client.new("#{host}/forum") }

      before { stub_post("#{host}/forum/test/post").with(body: { created: "object" }) }

      it "allows custom post requests" do
        client.post("/test/post", { created: "object" })
        expect(
          a_post("#{host}/forum/test/post").with(body: { created: "object" }),
        ).to have_been_made
      end
    end
  end

  describe "#put" do
    before do
      stub_put("#{host}/test/put").with(body: { updated: "object" })
      client.api_key = "test_d7fd0429940"
      client.api_username = "test_user"
    end

    it "allows custom put requests" do
      client.put("/test/put", { updated: "object" })
      expect(a_put("#{host}/test/put").with(body: { updated: "object" })).to have_been_made
    end

    context "when using a host with a subdirectory" do
      subject(:client) { DiscourseApi::Client.new("#{host}/forum") }

      before { stub_put("#{host}/forum/test/put").with(body: { updated: "object" }) }

      it "allows custom post requests" do
        client.put("/test/put", { updated: "object" })
        expect(a_put("#{host}/forum/test/put").with(body: { updated: "object" })).to have_been_made
      end
    end
  end

  describe "#request" do
    it "catches 500 errors" do
      connection = instance_double(Faraday::Connection)
      allow(connection).to receive(:get).and_return(
        OpenStruct.new(env: { body: "error page html" }, status: 500),
      )
      allow(Faraday).to receive(:new).and_return(connection)
      expect { client.send(:request, :get, "/test") }.to raise_error DiscourseApi::Error
    end

    it "catches Faraday errors" do
      allow(Faraday).to receive(:new).and_raise(Faraday::ClientError.new("BOOM!"))
      expect { client.send(:request, :get, "/test") }.to raise_error DiscourseApi::Error
    end

    it "catches JSON::ParserError errors" do
      allow(Faraday).to receive(:new).and_raise(JSON::ParserError.new("unexpected token"))
      expect { client.send(:request, :get, "/test") }.to raise_error DiscourseApi::Error
    end
  end
end
