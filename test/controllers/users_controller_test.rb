require 'test_helper'
include Warden::Test::Helpers

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
     ruby_path=::Rails.root.join("test/fixtures/paperclip/test_photo.jpg")
     @photo = File.new(ruby_path,'rb')
     @user = users(:david)
     @author = users(:author)
     @admin = users(:admin)
  end

  test "should no get users without login" do
    get "/users"
    follow_redirect!
    assert_equal "/", path
    assert_equal 200, status
  end

  test "should not go to users with login and not Administrator" do
    login_as(@user)
    get "/users"
    follow_redirect!
    assert_equal "/", path
    assert_equal 200, status
    Warden.test_reset!
  end

  test "should go users with login and Administrator" do
    login_as(@admin)
    get "/users"
    assert_equal 200, status # User gets root_path because he loged in
    assert_equal "/users", path
    Warden.test_reset!
  end

  test "admin should delete users" do
    login_as(@admin)
    user = users(:david)
    assert_difference('User.count', -1) do
      delete user_url(user)
    end
    follow_redirect!
    assert_equal "/users", path
    Warden.test_reset!
  end

  test "normal user not should delete users" do
    login_as(@user)
    user = users(:david)
    assert_difference('User.count', 0) do
      delete user_url(user)
    end
    follow_redirect!
    assert_equal "/", path
    Warden.test_reset!
  end

end
