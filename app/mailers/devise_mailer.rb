class DeviseMailer < Devise::Mailer
  default :from => 'ddlarosaoc@gmail.com'

  def self.mailer_name
    "devise/mailer"
  end
end
