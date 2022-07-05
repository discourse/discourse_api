# frozen_string_literal: true

require 'spec_helper'

describe DiscourseApi::SingleSignOn do
  context "::MissingConfigError" do
    it "inherits from RuntimeError for backward compatibility" do
      expect(DiscourseApi::SingleSignOn::MissingConfigError).to be < RuntimeError
    end
  end

  context "::ParseError" do
    it "inherits from RuntimeError for backward compatibility" do
      expect(DiscourseApi::SingleSignOn::ParseError).to be < RuntimeError
    end
  end

  context ".sso_secret" do
    it "raises MissingConfigError when sso_secret is not present" do
      expect {
        described_class.sso_secret
      }.to raise_error(DiscourseApi::SingleSignOn::MissingConfigError)
    end
  end

  context ".sso_url" do
    it "raises MissingConfigError when sso_url is not present" do
      expect {
        described_class.sso_url
      }.to raise_error(DiscourseApi::SingleSignOn::MissingConfigError)
    end
  end

  context ".parse" do
    it "raises ParseError when there's a signature mismatch" do
      sso = described_class.new
      sso.sso_secret = "abcd"
      expect {
        described_class.parse(sso.payload, "dcba")
      }.to raise_error(DiscourseApi::SingleSignOn::ParseError)
    end
  end
end
