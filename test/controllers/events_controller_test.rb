require 'test_helper'
include Warden::Test::Helpers

class EventsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
     ruby_path=::Rails.root.join("test/fixtures/paperclip/test_photo.jpg")
     @photo = File.new(ruby_path,'rb')
     @user = users(:david)
     @author = users(:author)
  end

  test "user can see home page whitout login" do
    get "/"
    assert_equal 200, status # User gets root_path because he loged in
    assert_equal "/", path
  end


  test "user go to home page when logout" do
     login_as(@user)

     get "/"
     assert_equal 200, status
     assert_equal "/", path
     logout
     get "/"
     assert_equal "/", path
     assert_equal 200, status
     Warden.test_reset! #reset Warden after each example
   end

   test "should not create event without login" do
     my_event = Event.new(
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

      post events_url, params: { event: { address: my_event.address, description: my_event.description, end_at: my_event.end_at, photo_file_name: my_event.photo_file_name, name: my_event.name, start_at: my_event.start_at } }
      follow_redirect!
      assert_equal "/", path
      assert_equal 200, status
   end


end
