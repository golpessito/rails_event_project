class OneDayBeforeEventNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Event.get_event_one_day_before_start.each do |event|
      event.attende.each do |user|
        EventMailer.with(user: user, event: event).send_notificacion_start_event.deliver
      end
    end
  end
  
end
