require 'rails_helper'

RSpec.describe ErrorsController, :type => :controller do

  describe "GET not_found" do
    subject { get :not_found }
    it { is_expected.to have_http_status :not_found }
    it { is_expected.to render_template :not_found }
  end

  describe "GET unprocessable_entity" do
    subject { get :unprocessable_entity }
    it { is_expected.to have_http_status :unprocessable_entity }
    it { is_expected.to render_template :unprocessable_entity }
  end

  describe "GET internal_server_error" do
    subject { get :internal_server_error }
    it { is_expected.to have_http_status :internal_server_error }
    it { is_expected.to render_template :internal_server_error }
  end

end
