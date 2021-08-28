require 'test_helper'

class TaskWorksControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get task_works_update_url
    assert_response :success
  end
end
