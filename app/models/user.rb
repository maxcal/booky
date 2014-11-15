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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: Devise.omniauth_configs.keys

  has_many :authentications
  accepts_nested_attributes_for :authentications

  # convert omniauth input to attributes
  # @param auth_hash [OmniAuth::AuthHash]
  def self.omniauth_hash_to_attributes(auth_hash)
    {
        email: auth_hash[:info][:email],
        password: Devise.friendly_token,
    }
  end

  # Finds or creates a user and authentication from an omniauth hash.
  # Will also update a previous authentication.
  # @return [User]
  # @param auth_hash [OmniAuth::AuthHash]
  # @raise [ActiveRecord::RecordInvalid]
  #   if the parameters from omniauth are not valid for creating a user or authenticion
  #
  def self.from_omniauth_hash!(auth_hash)
    user_attributes = User.omniauth_hash_to_attributes(auth_hash)
    auth = Authentication.from_omniauth_hash!(auth_hash)

    if auth.user
      user = auth.user
    else
      user = User.where(user_attributes.slice :email).first_or_create!(user_attributes.merge(authentications: [auth]))
    end

    user
  end
end
