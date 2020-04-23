require 'test_helper'

class QuestionSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_sets_index_url
    assert_response :success
  end

  test "should get new" do
    get question_sets_new_url
    assert_response :success
  end

  test "should get show" do
    get question_sets_show_url
    assert_response :success
  end

  test "should get edit" do
    get question_sets_edit_url
    assert_response :success
  end

  test "should get update" do
    get question_sets_update_url
    assert_response :success
  end

  test "should get create" do
    get question_sets_create_url
    assert_response :success
  end

  test "should get destroy" do
    get question_sets_destroy_url
    assert_response :success
  end

end
