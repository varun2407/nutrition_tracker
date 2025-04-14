class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create_commit :create_profile

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  private
    def create_profile
      build_profile.save
      #  self.profile = Profile.new(user: self)
      #  profile.save
    end
end
