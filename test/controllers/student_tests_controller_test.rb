require 'test_helper'

class StudentTestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_tests_index_url
    assert_response :success
  end

  test "should get show" do
    get student_tests_show_url
    assert_response :success
  end

  test "should get delete" do
    get student_tests_delete_url
    assert_response :success
  end

  test "should get destroy" do
    get student_tests_destroy_url
    assert_response :success
  end

end
