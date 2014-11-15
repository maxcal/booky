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

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| n == 1 ? "john.doe@example.com" : "test#{n}@example.com" }
    #forename 'John'
    #surname 'Doe'
    password 'P4ssword'
    password_confirmation 'P4ssword'
  end

  factory :admin, class: User  do
    sequence(:username) { |n| n == 1 ? "admin" : "admin-#{n}" }
    sequence(:email) { |n| n == 1 ? "admin@example.com" : "admin-#{n}@example.com" }
    password "abc123123"
    password_confirmation { "abc123123" }
    confirmed_at Time.now
    after(:create) do |user|
      user.add_role(:admin)
    end
  end

end
