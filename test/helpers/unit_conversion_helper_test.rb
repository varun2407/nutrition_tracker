require "test_helper"

class UnitConversionHelperTest < ActiveSupport::TestCase
  test "converts height from cm to feet and inches" do
    # Test case 1: 170 cm = 5'7"
    result = UnitConversionHelper.cm_to_ft_in(170)
    assert_equal 5, result[:feet]
    assert_in_delta 6.9, result[:inches], 0.1

    # Test case 2: 180 cm = 5'11"
    result = UnitConversionHelper.cm_to_ft_in(180)
    assert_equal 5, result[:feet]
    assert_in_delta 10.9, result[:inches], 0.1

    # Test case 3: 0 cm
    result = UnitConversionHelper.cm_to_ft_in(0)
    assert_equal 0, result[:feet]
    assert_equal 0, result[:inches]

    # Test case 4: nil
    result = UnitConversionHelper.cm_to_ft_in(nil)
    assert_equal 0, result[:feet]
    assert_equal 0, result[:inches]
  end

  test "converts weight from kg to lbs" do
    # Test case 1: 70 kg = 154.3 lbs
    assert_in_delta 154.3, UnitConversionHelper.kg_to_lbs(70), 0.1

    # Test case 2: 80 kg = 176.4 lbs
    assert_in_delta 176.4, UnitConversionHelper.kg_to_lbs(80), 0.1

    # Test case 3: 0 kg
    assert_equal 0, UnitConversionHelper.kg_to_lbs(0)

    # Test case 4: nil
    assert_equal 0, UnitConversionHelper.kg_to_lbs(nil)
  end

  test "formats height string correctly" do
    assert_equal "5'7\"", UnitConversionHelper.format_height(5, 7)
    assert_equal "6'0\"", UnitConversionHelper.format_height(6, 0)
    assert_equal "5'11.5\"", UnitConversionHelper.format_height(5, 11.5)
  end
end
