require 'test_helper'

class EventTest < ActiveSupport::TestCase
  fixtures :users

  #Check create event
  def new_event(photo_file_name)
    Event.new(name: "Pirate Gymkana",
      description: "Pirate Gymkana description",
      address:"C/Barquillo, Madrid, Madrid",
      start_at: "2018-09-12 15:00:00",
      end_at: "2018-09-12 18:00:00",
      photo_content_type: "image/jpeg",
      photo_file_size: 23296,
      photo_file_name:photo_file_name,
      latitude: 40.0321293,
      longitude: -3.6028448,
      user: users(:david))
  end

  test "Event attributes must not be empty" do
    event = Event.new
    assert event.invalid?
    assert event.errors[:name].any?
    assert event.errors[:description].any?
    assert event.errors[:address].any?
    assert event.errors[:photo_file_name].any?
    assert event.errors[:start_at].any?
    assert event.errors[:end_at].any?
  end

  #Check photo file name has a good format
  test "photo_file_name" do

    ok = %w{ fred.gif fred.jpg fred.png}
    bad = %w{ fred.gixf, fred.doc, fred.pdf}

    ok.each do |name|
        assert new_event(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
        assert new_event(name).invalid?, "#{name} should be invalid"
    end

  end

  #Check uniquenness name event
  test "event is not valid without a unique name event" do
      event = Event.new(name: "Madrid Rio",
                        description: "Pirate Gymkana description",
                        address:"C/Barquillo, Madrid, Madrid",
                        start_at: "2018-09-12 15:00:00",
                        end_at: "2018-09-12 18:00:00",
                        photo_content_type: "image/jpeg",
                        photo_file_size: 23296,
                        photo_file_name:"madrid_rio.jpg",
                        latitude: 40.0321293,
                        longitude: -3.6028448,
                        user: users(:david))

        assert event.invalid?
        assert_equal ["has already been taken"], event.errors[:name]
  end

  #Check vald start at and end at date in event
  test "event is not valid if the end_at date is sonner than start_at " do

    event = Event.new(name: "The Caribean Pirate Event",
                      description: "Pirate Gymkana description",
                      address:"C/Barquillo, Madrid, Madrid",
                      start_at: "2018-09-12 15:00:00",
                      end_at: "2018-09-11 18:00:00",
                      photo_content_type: "image/jpeg",
                      photo_file_size: 23296,
                      photo_file_name:"madrid_rio.jpg",
                      latitude: 40.0321293,
                      longitude: -3.6028448,
                      user: users(:david))

    assert_not event.save, "Event can't have end_at sonner than start_at"
  end

end
