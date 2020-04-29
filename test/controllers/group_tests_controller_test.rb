require 'test_helper'

class GroupTestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get group_tests_index_url
    assert_response :success
  end

  test "should get show" do
    get group_tests_show_url
    assert_response :success
  end

  test "should get edit" do
    get group_tests_edit_url
    assert_response :success
  end

  test "should get update" do
    get group_tests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get group_tests_destroy_url
    assert_response :success
  end

end
