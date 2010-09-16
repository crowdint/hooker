Mail.defaults do
  #
  # Example on how to use it with Sendgrid / Heroku
  #
  delivery_method :smtp, {
    :port => 25,
    :address => "smtp.sendgrid.net",
    :domain => ENV["SENDGRID_DOMAIN"],
    :authentication => "plain",
    :user_name => ENV["SENDGRID_USERNAME"],
    :password => ENV["SENDGRID_PASSWORD"]
  }
end