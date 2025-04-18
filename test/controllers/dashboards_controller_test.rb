require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "show as user" do
    login_as varun

    get root_path

    assert_response :success
    assert_select "h2", "Calories for #{Date.today.strftime("%B %d, %Y")}:"
  end

  test "show as guest" do
    get root_path

    assert_redirected_to new_session_path
  end
end
