require 'test_helper'

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :events

  setup do
     ruby_path=::Rails.root.join("test/fixtures/paperclip/test_photo.jpg")
     @photo = File.new(ruby_path,'rb')
     @user = users(:david)
     @author = users(:author)
     @admin = users(:admin)
     @madrid_rio=events(:madrid_rio)
  end

  test "should be attend when I login" do
    login_as(@user)
    assert_difference('Rsvp.count', +1) do
      post rsvps_url,  params: { rsvp: { event_id: @madrid_rio.id } }
      follow_redirect!
    end

    Warden.test_reset!
  end

  test "should not be attend when I login" do
    assert_difference('Rsvp.count', 0) do
      post rsvps_url,  params: { rsvp: { event_id: @madrid_rio.id } }
      follow_redirect!
    end

    Warden.test_reset!
  end

end
