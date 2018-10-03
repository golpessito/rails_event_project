require 'test_helper'

class RsvpTest < ActiveSupport::TestCase
  fixtures :users
  fixtures :events

  test "Rsvps attributes dont be empty" do
    rsvp = Rsvp.new
    assert rsvp.invalid?
  end

  test "Create without user will be invalid" do
    rsvp = Rsvp.new
    rsvp.events_to_attend=events(:madrid_rio)
    assert rsvp.invalid?
  end

  test "Create without event will be invalid" do
    rsvp = Rsvp.new
    rsvp.attende=users(:david)
    assert rsvp.invalid?
  end

  test "Create" do
    rsvp = Rsvp.new
    rsvp.events_to_attend=events(:madrid_rio)
    rsvp.attende=users(:david)
    assert rsvp.valid?
  end

end
