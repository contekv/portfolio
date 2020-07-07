require "test_helper"

class TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get tops_home_url
    assert_response :success
  end

  test "should get help" do
    get tops_help_url
    assert_response :success
  end

end
