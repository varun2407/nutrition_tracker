require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "factory" do
    assert build(:user).validate!
  end

  test "destroy" do
    assert varun.destroy!
  end
end
