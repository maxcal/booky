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

# Represents a Oath2 authentication
class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :uid, scope: :provider
  validates_inclusion_of :provider, in: Devise.omniauth_configs.keys.map(&:to_s)
end