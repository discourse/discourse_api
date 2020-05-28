# frozen_string_literal: true
require 'spec_helper'

describe DiscourseApi::API::SSO do
  subject { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user") }

  let(:params) do
    {
      sso_secret: 'abc',
      sso_url: 'www.google.com',
      name: 'Some User',
      username: 'some_user',
      email: 'some@email.com',
      external_id: 'abc',
      suppress_welcome_message: false,
      avatar_url: 'https://www.website.com',
      title: 'ruby',
      avatar_force_update: false,
      add_groups: ['a', 'b'],
      remove_groups: ['c', 'd'],
      # old format (which results in custom.custom.field_1 in unsigned_payload)
      'custom.field_1' => 'tomato',
      # new format
      custom_fields: {
        field_2: 'potato'
      }
    }
  end
  let(:expected_unsigned_payload) do
    'name=Some+User&username=some_user&email=some%40email.com&'\
    'avatar_url=https%3A%2F%2Fwww.website.com&external_id=abc&title=ruby'\
    '&add_groups=a&add_groups=b&remove_groups=c&remove_groups=d&custom.field_2=potato&'\
    'custom.custom.field_1=tomato'
  end
  let(:sso_double) { DiscourseApi::SingleSignOn.parse_hash(params) }

  describe "#sync_sso" do
    before do
      stub_post(/.*sync_sso.*/).to_return(
        body: fixture("user.json"),
        headers: { content_type: "application/json" }
      )
    end

    it 'assigns params to sso instance' do
      allow(DiscourseApi::SingleSignOn).to(receive(:parse_hash).with(params).and_return(sso_double))

      subject.sync_sso(params)

      expect(sso_double.custom_fields).to eql({ 'custom.field_1' => 'tomato', :field_2 => 'potato' })
      expect(sso_double.unsigned_payload).to eql(expected_unsigned_payload)
    end

    it "requests the correct resource" do
      subject.sync_sso({ sso_secret: "test_d7fd0429940", "custom.riffle_url" => "test" })
      expect(a_post(/.*sync_sso.*/)).to have_been_made
    end
  end
end
