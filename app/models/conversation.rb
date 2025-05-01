class Conversation < ApplicationRecord
  include AASM

  aasm do
    state :waiting_for_food_details, initial: true
    state :waiting_for_brand_choice
    state :waiting_for_meal_type
    state :conversation_complete

    event :receive_food_details do
      transitions from: :waiting_for_food_details, to: :waiting_for_brand_choice, guard: :multiple_brands_found?
      transitions from: :waiting_for_food_details, to: :waiting_for_meal_type, guard: :meal_type_missing?
      transitions from: :waiting_for_food_details, to: :conversation_complete, unless: :additional_info_needed?
    end

    event :select_brand do
      transitions from: :waiting_for_brand_choice, to: :waiting_for_meal_type, guard: :meal_type_missing?
      transitions from: :waiting_for_brand_choice, to: :conversation_complete, unless: :meal_type_missing?
    end

    event :provide_meal_type do
      transitions from: :waiting_for_meal_type, to: :conversation_complete
    end
  end

  def multiple_brands_found?
    false
  end

  def meal_type_missing?
    true
  end

  def additional_info_needed?
    multiple_brands_found? || meal_type_missing?
  end
end