require 'rails_helper'
require 'support/helpers/omniauth_helper'

RSpec.feature "Facebook Authentication" do

  include OmniauthCredentialsHelper

  let(:provider) { :facebook }
  let(:valid_credentials!) { OmniauthCredentialsHelper.valid_credentials!(provider) }
  let(:invalid_credentials!) { OmniauthCredentialsHelper.invalid_credentials!(provider) }

  scenario "I should be able to login with facebook from login page" do
    visit new_user_session_path
    expect(page).to have_link I18n.t('devise.shared.auth_providers.sign_up_with', provider: 'Facebook')
  end

  context 'given a valid authentication provider response' do
    background do
      valid_credentials!
    end
    scenario 'I should be authenticated' do
      visit new_user_registration_path
      click_link I18n.t('devise.shared.auth_providers.sign_up_with', provider: 'Facebook')
      expect(page).to have_content I18n.t!('devise.omniauth_callbacks.success', kind: 'Facebook', reason: 'foo')
    end
  end

  context 'given a invalid authentication provider response' do
    background do
      invalid_credentials!
    end
    scenario 'I should get a message telling me that authentication failed' do
      visit new_user_registration_path
      click_link I18n.t!('devise.shared.auth_providers.sign_up_with', provider: 'Facebook')
      expect(page).to have_content I18n.t!('devise.omniauth_callbacks.failure', kind: 'Facebook', reason: "Invalid credentials")
    end
  end
end