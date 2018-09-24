# README
# Start REDIS
sudo systemctl start redis
sudo systemctl status redis

# Start sidekiq
bundle exec sidekiq

# Run Nofitication One Day Before
OneDayBeforeEventNotificationsJob.perform_later()

# Run wheneverize
bundle exec wheneverize .

#Update crontab
whenever --update-crontab
bundle exec whenever crontab -l
https://medium.com/coffee-and-codes/schedule-tasks-using-whenever-gem-ruby-on-rails-50b9af025607
