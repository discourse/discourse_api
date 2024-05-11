# frozen_string_literal: true

require "spec_helper"

describe DiscourseApi::SingleSignOn do
  describe DiscourseApi::SingleSignOn::MissingConfigError do
    it "inherits from RuntimeError for backward compatibility" do
      expect(DiscourseApi::SingleSignOn::MissingConfigError).to be < RuntimeError
    end
  end

  describe DiscourseApi::SingleSignOn::ParseError do
    it "inherits from RuntimeError for backward compatibility" do
      expect(DiscourseApi::SingleSignOn::ParseError).to be < RuntimeError
    end
  end

  describe ".sso_secret" do
    it "raises MissingConfigError when sso_secret is not present" do
      expect { described_class.sso_secret }.to raise_error(
        DiscourseApi::SingleSignOn::MissingConfigError,
      )
    end
  end

  describe ".sso_url" do
    it "raises MissingConfigError when sso_url is not present" do
      expect { described_class.sso_url }.to raise_error(
        DiscourseApi::SingleSignOn::MissingConfigError,
      )
    end
  end

  describe ".parse" do
    context "when sso is present" do
      it "raises ParseError when there's a signature mismatch" do
        sso = described_class.new
        sso.sso_secret = "abcd"
        expect { described_class.parse(sso.payload, "dcba") }.to raise_error(
          DiscourseApi::SingleSignOn::ParseError,
        )
      end
    end

    context "when sso is missing" do
      it "raises ParseError when there's a signature mismatch" do
        sso = described_class.new
        sso.sso_secret = "abcd"
        missing_sso = Rack::Utils.parse_query(sso.payload)
        missing_sso.delete("sso")
        malformed_query = Rack::Utils.build_query(missing_sso)

        expect { described_class.parse(malformed_query, "dcba") }.to raise_error(
          DiscourseApi::SingleSignOn::ParseError,
          /The SSO field should/i,
        )
      end
    end
  end
end
