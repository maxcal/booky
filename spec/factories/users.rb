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
#  surename               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

FactoryGirl.define do
  factory :user do
    email 'john.doe@example.com'
    #forename 'John'
    #surname 'Doe'
    password 'P4ssword'
    password_confirmation 'P4ssword'
  end
end
