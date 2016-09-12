require 'test_helper'

class PlatformsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @platform = Platform.new(name: 'TestPlatform', address: 'www.address.test')
  end

  test "should get index" do
    get platforms_url
    assert_response :success
  end

  test "should show platform" do
    get platforms_url(@platform.id)
    assert_response :success
  end
end
