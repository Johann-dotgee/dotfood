ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "dotfood.dotgee.fr",
  :user_name            => "noreply@dotfood.dotgee.net",
  :password             => "",
  :authentication       => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "dotfood.dotgee.net"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?