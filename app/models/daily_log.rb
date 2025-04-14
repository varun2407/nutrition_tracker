class DailyLog < ApplicationRecord
  belongs_to :profile
  has_many :food_entries, dependent: :destroy
end
