require 'rails_helper'

class BoomError < StandardError; end

RSpec.feature "Custom error pages" do

  context "when I visit a page that does not exist" do
    scenario "it should give me the correct error page" do
      visit '/gobiligook'
      expect(page).to have_content "Unfortunatly we cannot find the resource you are looking for."
    end
  end

  context "when I visit a page that blows up" do
    background do
      allow_any_instance_of(HomeController).to receive(:index).and_raise(BoomError, 'Application went boom-shacka-lacka')
    end

    scenario "it should give me the correct error page" do
      visit '/'
      expect(page).to have_content "A critical error occured - we are very sorry. Please try again later."
    end
  end

  context "when I post an unprocessable entity" do
    scenario "not sure how to test this yet"
  end
end