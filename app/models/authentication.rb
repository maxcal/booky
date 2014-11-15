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

  # Find or create an authentication from OmniAuth params
  # @param auth_hash [OmniAuth::AuthHash ]

  def self.from_omniauth_hash!(auth_hash)
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    auth = self.where(attrs.slice(:uid, :provider)).first_or_create!(attrs)
    auth.update!(attrs) unless auth.new_record?
    auth
  end

  private
  # Convert an Omniauth response into a hash of attributes
  # @param auth_hash [OmniAuth::AuthHash ]
  # @return [Hash]
  def self.omniauth_hash_to_attributes(auth_hash)
    {
      uid: auth_hash[:uid],
      provider: auth_hash[:provider],
      token: auth_hash[:credentials][:token],
      expires_at: DateTime.strptime("#{auth_hash[:credentials][:expires_at]}", '%s')
    }
  end
end