require "test_helper"

class PosturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postures_index_url
    assert_response :success
  end

  test "should get show" do
    get postures_show_url
    assert_response :success
  end

  test "should get new" do
    get postures_new_url
    assert_response :success
  end

  test "should get create" do
    get postures_create_url
    assert_response :success
  end

  test "should get edit" do
    get postures_edit_url
    assert_response :success
  end

  test "should get update" do
    get postures_update_url
    assert_response :success
  end

  test "should get destroy" do
    get postures_destroy_url
    assert_response :success
  end
end
