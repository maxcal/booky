require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  let(:user) { create(:user) }
  let(:auth) { build_stubbed(:authentication, user: user) }

  subject { Ability.new(user) }

  context "a guest user" do
    it { should be_able_to(:crud, user, "should be able to manage self") }
    it { should_not be_able_to(:crud, User.new, "should not be able to manage others") }
    it { should be_able_to(:crud, auth) }
    it { should_not be_able_to(:crud, build_stubbed(:authentication)) }
  end

  context "an admin" do
    before { user.add_role :admin }
    it { should be_able_to(:manage, User) }
    it { should be_able_to(:manage, Authentication) }
  end
end