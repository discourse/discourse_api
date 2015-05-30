require 'spec_helper'

describe DiscourseApi::API::SSO do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user" )}

  describe "#sync_sso" do
    before do
      stub_post(/.*sync_sso.*/).to_return(body: fixture("user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.sync_sso({sso_secret: "test_d7fd0429940", "custom.riffle_url" => "test"})
      expect(a_post(/.*sync_sso.*/)).to have_been_made
    end
  end
end
