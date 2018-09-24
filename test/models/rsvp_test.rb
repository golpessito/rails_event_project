require 'test_helper'

class RsvpTest < ActiveSupport::TestCase
  fixtures :users
  fixtures :events

  test "Rsvps attributes dont be empty" do
    rsvp = Rsvp.new
    assert rsvp.invalid?
  end

  test "Create" do
    rsvp = Rsvp.new
    rsvp.events_to_attend=events(:madrid_rio)
    rsvp.attende=users(:david)
    assert rsvp.valid?
  end

end
