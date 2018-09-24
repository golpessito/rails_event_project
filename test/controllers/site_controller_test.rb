require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  test "should home page without login " do
    get root_url
    assert_response :success
  end
end
