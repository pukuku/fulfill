require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_update_url
    assert_response :success
  end

  test "should get quit_confirm" do
    get users_quit_confirm_url
    assert_response :success
  end

  test "should get quit" do
    get users_quit_url
    assert_response :success
  end

end
