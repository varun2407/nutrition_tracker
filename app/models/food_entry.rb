class FoodEntry < ApplicationRecord
  belongs_to :daily_log

  enum meal_type: {
    lunch => 0
   }
end
