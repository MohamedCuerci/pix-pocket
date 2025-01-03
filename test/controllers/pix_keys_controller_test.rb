require "test_helper"

class PixKeysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pix_keys_index_url
    assert_response :success
  end

  test "should get show" do
    get pix_keys_show_url
    assert_response :success
  end

  test "should get new" do
    get pix_keys_new_url
    assert_response :success
  end

  test "should get create" do
    get pix_keys_create_url
    assert_response :success
  end

  test "should get edit" do
    get pix_keys_edit_url
    assert_response :success
  end

  test "should get update" do
    get pix_keys_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pix_keys_destroy_url
    assert_response :success
  end
end
