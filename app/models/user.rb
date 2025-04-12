class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create_commit :create_profile

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
