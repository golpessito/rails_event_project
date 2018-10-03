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

     @event = Event.new(
       name: "Madrid Rio4",
       address: "C/Florida, Aranjuez, Madrid",
       start_at: "2018-09-01 11:14:17",
       end_at: "2018-09-01 12:14:17",
       photo_file_name: "florida.jpg",
       description: "This is the best music event ever ...",
       latitude: 40.0321293,
       longitude: -3.6028448,
       user: @author,
       photo: @photo)
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
