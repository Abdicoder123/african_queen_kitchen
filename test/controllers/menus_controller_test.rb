require "test_helper"

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get menus_index_url
    assert_response :success
  end

  test "should get show" do
    get menus_show_url
    assert_response :success
  end
end
