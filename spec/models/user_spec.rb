# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  forename               :string(255)
#  surname                :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'rails_helper'
require 'support/helpers/omniauth_helper'

RSpec.describe User do
  it { should validate_uniqueness_of :email }
  it { should have_many :authentications }

  describe '._from_omniauth_hash!' do
    let(:auth_hash) { OmniauthCredentialsHelper.valid_credentials_hash }

    it "returns the user" do
      expect(User.from_omniauth_hash!(auth_hash)).to be_a User
    end

    context 'given a user with authentication' do
      let!(:user) { create(:user, email: 'joe@bloggs.com') }
      let!(:auth) { create(:authentication, user: user, uid: '1234567', provider: 'facebook') }

      it "does not create a new user" do
        expect {
          User.from_omniauth_hash!(auth_hash)
        }.to_not change(User, :count)
      end
    end
    context 'when user with given email exists' do
      let!(:user) { create :user, email: 'joe@bloggs.com' }
      it "does not create a new user" do
        expect {
          User.from_omniauth_hash!(auth_hash)
        }.to_not change(User, :count)
      end
    end
    context 'when user does not exist' do
      let(:user) { User.from_omniauth_hash!(auth_hash) }
      it "creates a new user" do
        expect {
          User.from_omniauth_hash!(auth_hash)
        }.to change(User, :count).by(+1)
      end
      it "has the correct email" do
        expect(user.email).to eq 'joe@bloggs.com'
      end
    end
  end
end