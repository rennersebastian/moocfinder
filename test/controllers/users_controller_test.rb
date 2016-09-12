require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @password = "password"
    @user = User.create(email: "#{rand(50000)}@example.com", 
                                  password: @password)
  end

  test "should not get dashboard" do
    get dashboard_url
    assert_response :redirect 
  end
  
  test "should get dashboard" do
	sign_in @user
    get dashboard_url
    assert_response :success 
  end
  
  test "should sign out user" do
	sign_in @user
    get dashboard_url
    assert_response :success 
	sign_out @user
  end
end
