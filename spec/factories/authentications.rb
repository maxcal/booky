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

FactoryGirl.define do
  factory :authentication do
    user nil
    uid '123456789'
    provider :facebook
  end
end