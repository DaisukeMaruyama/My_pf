require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contacts_new_url
    assert_response :success
  end

  test "should get create" do
    get contacts_create_url
    assert_response :success
  end

  test "should get back" do
    get contacts_back_url
    assert_response :success
  end

  test "should get confirm" do
    get contacts_confirm_url
    assert_response :success
  end

  test "should get done" do
    get contacts_done_url
    assert_response :success
  end

end
