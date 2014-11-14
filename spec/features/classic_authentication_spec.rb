require 'rails_helper'

RSpec.feature "Classic Authentication" do

  let(:submit) {  find(:css, 'input[type="submit"]') }
  let(:user) { FactoryGirl.create(:user) }

  context 'Registation' do
    background do
      visit new_user_registration_path
      page.fill_in 'Email', with: 'test@example.com'
      page.fill_in 'Password', with: 'P4ssword'
      page.fill_in 'Password confirmation', with: 'P4ssword'
    end
    scenario "when I sign up with valid info" do
      submit.click
      expect(page).to have_content I18n.t('devise.registrations.signed_up')
      expect(page).to have_content I18n.t('user.sign_out')
    end
    scenario "when I sign up with invalid info" do
      page.fill_in 'Email', with: 'testasdas'
      submit.click
      expect(page).to have_content 'Email is invalid'
      expect(page).to_not have_content I18n.t('devise.registrations.signed_up')
    end
  end

  context 'Log in' do
    background do
      visit '/'
      click_link I18n.t('user.sign_in')
      page.fill_in 'Email', with: user.email
    end
    scenario 'when I sign in with valid details.' do
      page.fill_in 'Password', with: 'P4ssword'
      submit.click
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
      expect(page).to have_link I18n.t('user.sign_out')
    end
    scenario 'when I sign in with an invalid password' do
      page.fill_in 'Password', with: 'H4XX0R'
      submit.click
      expect(page).to_not have_content I18n.t('devise.sessions.signed_in')
    end
  end

  context 'Log out' do
    background do
      visit new_user_session_path
      click_link I18n.t('user.sign_in')
      page.fill_in 'Email', with: user.email
      page.fill_in 'Password', with: 'P4ssword'
      submit.click
    end
    scenario "when I am logged in and press signout button" do
      click_link I18n.t('user.sign_out')
      expect(page).to have_content I18n.t('devise.sessions.signed_out')
    end
  end
end