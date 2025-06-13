module UnitConversionHelper
  # Convert height from centimeters to feet and inches
  # @param cm [Float] height in centimeters
  # @return [Hash] hash containing feet and inches
  def self.cm_to_ft_in(cm)
    return { feet: 0, inches: 0 } if cm.nil? || cm <= 0

    total_inches = cm / 2.54
    feet = total_inches.floor / 12
    inches = (total_inches % 12).round(2)

    { feet: feet, inches: inches }
  end

  # Convert weight from kilograms to pounds
  # @param kg [Float] weight in kilograms
  # @return [Float] weight in pounds
  def self.kg_to_lbs(kg)
    return 0 if kg.nil? || kg <= 0
    (kg * 2.20462).round(2)
  end

  # Format height in feet and inches
  # @param feet [Integer] number of feet
  # @param inches [Float] number of inches
  # @return [String] formatted height string
  def self.format_height(feet, inches)
    "#{feet}'#{inches}\""
  end
end
