class Food < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :carbs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fat, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }, if: -> { user_id.present? }

  scope :system_foods, -> { where(user_id: nil) }
  scope :user_foods, ->(user) { where(user_id: user.id) }
  scope :searchable_by, ->(user) { where(user_id: [nil, user.id]) }
end
