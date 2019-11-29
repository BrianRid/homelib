require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get documents_create_url
    assert_response :success
  end

  test "should get show" do
    get documents_show_url
    assert_response :success
  end

  test "should get update" do
    get documents_update_url
    assert_response :success
  end

  test "should get delete" do
    get documents_delete_url
    assert_response :success
  end

end
