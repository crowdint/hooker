require 'mail'

Mail.defaults do
  #
  # Example on how to use it with Sendgrid / Heroku
  #
  delivery_method :smtp, {
    :address => "smtp.sendgrid.com",
    :port => 25,
    :domain => ENV["SENDGRID_DOMAIN"],
    :authentication => "plain",
    :user_name => ENV["SENDGRID_USERNAME"],
    :password => ENV["SENDGRID_PASSWORD"]
  }
end