ActionMailer::Base.smtp_settings = {
  :address              => "localhost",
  :port                 => 25,
  :domain               => "dotgee.net",
}

ActionMailer::Base.default_url_options[:host] = "dotfood.dotgee.net"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?