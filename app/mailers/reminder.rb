class Reminder < ActionMailer::Base
  default :from => "Dotfood <noreply@dotfood.net>", :subject => "Dotfood Reminder"
  
  def reminder(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>")
  end
end
