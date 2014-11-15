# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string(255)
#  provider   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'support/helpers/omniauth_helper'

RSpec.describe Authentication do
  it { should belong_to :user }
  it { should validate_uniqueness_of :uid }
  it { should validate_inclusion_of(:provider).in_array(['facebook']) }

  describe '.from_omniauth_hash!' do

    let(:auth_hash) { OmniauthCredentialsHelper.valid_credentials_hash }

    context "when auth exists" do
      let!(:auth) { create(:authentication, uid: auth_hash[:uid], provider: auth_hash[:provider] ) }
      it "does not create a new auth" do
        expect {
          Authentication.from_omniauth_hash!(auth_hash)
        }.to_not change(Authentication, :count)
      end
      it "updates exisiting auth" do
        auth = Authentication.from_omniauth_hash!(auth_hash.merge(credentials: { token: 'new token value' }))
        expect(auth.token).to eq 'new token value'
      end
    end
    context "new record" do
      subject { Authentication.from_omniauth_hash!(auth_hash) }
      it "should have the correct uid" do
        expect(subject.uid).to eq(auth_hash[:uid])
      end
      it "should have the correct provider" do
        expect(subject.provider).to eq(auth_hash[:provider])
      end
      it "should have the correct expires_at" do
        expect(subject.expires_at).to eq(DateTime.strptime("#{auth_hash[:credentials][:expires_at]}", '%s'))
      end
      it "should have the correct token" do
        expect(subject.token).to eq(auth_hash[:credentials][:token])
      end
    end
  end
end