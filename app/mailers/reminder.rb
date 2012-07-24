class Reminder < ActionMailer::Base
  default :from => "reminder@dotfood.dotgee.net", :subject => "Dotfood Reminder"
  
  def reminder(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>")
  end
end
