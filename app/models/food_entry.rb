class FoodEntry < ApplicationRecord
  belongs_to :daily_log
  belongs_to :food

  enum :meal_type, { breakfast: 0, lunch: 1, dinner: 2, snacks: 3 }, default: :breakfast
end
