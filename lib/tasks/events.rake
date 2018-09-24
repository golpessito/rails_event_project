namespace :events do
  desc "Mail all users before one day the event start"
  task mail_before_one_day_event: :environment do
    OneDayBeforeEventNotificationsJob.perform_later()
    puts "#{Time.now} — Success!"
  end
end
