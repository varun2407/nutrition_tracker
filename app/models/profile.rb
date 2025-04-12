class Profile < ApplicationRecord
  belongs_to :user
  has_one :goal, dependent: :destroy
  has_many :daily_logs, dependent: :destroy
end
