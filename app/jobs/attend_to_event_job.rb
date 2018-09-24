class AttendToEventJob < ApplicationJob
  # Set the Queue as Default
  queue_as :default

  def perform(*args)
    user=args[0]
    event=args[1]
    # Do something later
    UserMailer.with(user: user, event: event).attend_to_event.deliver
  end
end
