require 'test_helper'

class OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get order_create_url
    assert_response :success
  end

  test "should get destroy" do
    get order_destroy_url
    assert_response :success
  end

end
