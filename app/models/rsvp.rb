class Rsvp < ApplicationRecord

  belongs_to :attende, foreign_key: "user_id", class_name: "User"
  belongs_to :events_to_attend, foreign_key: "event_id", class_name: "Event"

  #Validate the same event can be attend for two users once
  validates :events_to_attend, uniqueness: { scope: :attende }
end
