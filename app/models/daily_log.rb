class DailyLog < ApplicationRecord
  belongs_to :user
  has_many :food_entries, dependent: :destroy
end
