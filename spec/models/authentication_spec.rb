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

RSpec.describe Authentication do
  it { should belong_to :user }
  it { should validate_uniqueness_of :uid }
  it { should validate_inclusion_of(:provider).in_array(['facebook']) }
end
