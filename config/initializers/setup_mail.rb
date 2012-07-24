ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "dotfood.dotgee.fr",
  :user_name            => "dark.auroox@gmail.com",
  :password             => "1tmby9p7",
  :authentication       => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?