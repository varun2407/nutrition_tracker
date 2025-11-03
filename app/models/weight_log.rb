class WeightLog < ApplicationRecord
  self.table_name = "weights"

  belongs_to :user

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :measured_at, presence: true
  validates :measured_at, uniqueness: { scope: :user_id }

  scope :recent, -> { order(measured_at: :desc) }
  scope :for_date_range, ->(start_date, end_date) { where(measured_at: start_date..end_date) }

  alias_attribute :logged_date, :measured_at

  # Returns weight in the user's preferred unit
  def display_weight
    return weight if user.profile.metric?
    UnitConversionHelper.kg_to_lbs(weight)
  end

  # Returns the unit symbol based on user's preference
  def weight_unit
    user.profile.metric? ? "kg" : "lbs"
  end

  # Converts input weight to kg before saving
  def weight=(value)
    return super(value) if value.nil?
    value = value.to_f
    if user&.profile&.imperial?
      value = value / 2.20462 # Convert lbs to kg
    end
    super(value)
  end
end
