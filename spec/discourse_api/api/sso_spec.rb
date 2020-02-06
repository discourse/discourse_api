require 'spec_helper'

describe DiscourseApi::API::SSO do
  subject { DiscourseApi::Client.new("#{host}", "test_d7fd0429940", "test_user" )}

  let(:params) do
    {
      sso_secret: 'abc',
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
      'custom.custom.field_1' => 'potato',
      'custom.field_2' => 'tomato'
    }
  end
  let(:sso_double) { DiscourseApi::SingleSignOn.new }

  describe "#sync_sso" do
    before do
      stub_post(/.*sync_sso.*/).to_return(
        body: fixture("user.json"),
        headers: { content_type: "application/json" }
      )
      expect(DiscourseApi::SingleSignOn).to(receive(:new).and_return(sso_double))
    end

    it 'assigns params to sso instance' do
      expect(sso_double).to receive(:sso_secret=).with(params[:sso_secret]).and_call_original
      expect(sso_double).to receive(:name=).with(params[:name]).and_call_original
      expect(sso_double).to receive(:username=).with(params[:username]).and_call_original
      expect(sso_double).to receive(:email=).with(params[:email]).and_call_original
      expect(sso_double).to receive(:external_id=).with(params[:external_id]).and_call_original
      expect(sso_double).to receive(:suppress_welcome_message=).with(params[:suppress_welcome_message]).and_call_original
      expect(sso_double).to receive(:avatar_url=).with(params[:avatar_url]).and_call_original
      expect(sso_double).to receive(:title=).with(params[:title]).and_call_original
      expect(sso_double).to receive(:avatar_force_update=).with(params[:avatar_force_update]).and_call_original
      expect(sso_double).to receive(:add_groups=).with(params[:add_groups]).and_call_original
      expect(sso_double).to receive(:remove_groups=).with(params[:remove_groups]).and_call_original
      expect(sso_double).to receive(:custom_fields).twice.and_call_original
      expect(sso_double).to receive(:payload).and_call_original

      subject.sync_sso(params)

      expect(sso_double.instance_variable_get(:@custom_fields)).to(
        eql({ 'custom.field_1' => 'potato', 'field_2' => 'tomato' })
      )
      expect(sso_double.unsigned_payload).to include('custom.field_1')
      expect(sso_double.unsigned_payload).to include('custom.field_2')
    end

    it "requests the correct resource" do
      subject.sync_sso({ sso_secret: "test_d7fd0429940", "custom.riffle_url" => "test" })
      expect(a_post(/.*sync_sso.*/)).to have_been_made
    end
  end
end
