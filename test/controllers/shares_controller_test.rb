require 'test_helper'

class SharesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shares_index_url
    assert_response :success
  end

  test "should get show" do
    get shares_show_url
    assert_response :success
  end

  test "should get new" do
    get shares_new_url
    assert_response :success
  end

  test "should get create" do
    get shares_create_url
    assert_response :success
  end

  test "should get edit" do
    get shares_edit_url
    assert_response :success
  end

  test "should get update" do
    get shares_update_url
    assert_response :success
  end

  test "should get destroy" do
    get shares_destroy_url
    assert_response :success
  end

end
