class Profile < ApplicationRecord
  belongs_to :user

  UNIT_PREFERENCES = %w[metric imperial].freeze

  validates :unit_preference, inclusion: { in: UNIT_PREFERENCES }
  validates :height, numericality: { greater_than: 0, allow_nil: true }

  # Returns height in feet and inches format
  def height_in_ft_in
    return nil if height.nil?
    conversion = UnitConversionHelper.cm_to_ft_in(height)
    UnitConversionHelper.format_height(conversion[:feet], conversion[:inches])
  end

  # Returns height in centimeters
  def height_in_cm
    return nil if height.nil?
    height
  end

  # Returns the latest weight in pounds
  def latest_weight_in_lbs
    return nil if weights.empty?
    UnitConversionHelper.kg_to_lbs(weights.last.weight)
  end

  # Converts height from feet and inches to centimeters
  def self.convert_ft_in_to_cm(feet, inches)
    total_inches = (feet * 12) + inches
    (total_inches * 2.54).round(2)
  end

  # Virtual attributes for imperial height input
  attr_accessor :height_feet, :height_inches

  before_validation :convert_imperial_height_to_cm, if: :imperial?

  private

  def imperial?
    unit_preference == "imperial"
  end

  def convert_imperial_height_to_cm
    return unless height_feet.present? && height_inches.present?
    self.height = self.class.convert_ft_in_to_cm(height_feet.to_i, height_inches.to_f)
  end
end
