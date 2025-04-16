require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "show as guest" do
    get root_path

    assert_redirected_to new_session_path
  end
end
