class FoodEntry < ApplicationRecord
  belongs_to :daily_log

  enum meal_type: { breakfast: 0, lunch: 1, dinner: 2, snack: 3 }
end
