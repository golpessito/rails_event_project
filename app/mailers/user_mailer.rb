class UserMailer < ApplicationMailer
  def attend_to_event
    @user = params[:user]
    @event = params[:event]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Attend to event #{@event.name}")
  end
end
