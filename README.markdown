# hooker

Rack app to manage your github POST hooks

## Configuration

### Mail

Modify *config/mail.rb* to suit your needs. You can find all the options [here](http://github.com/mikel/mail).
An example on how to use it with Sendgrid on Heroku:

    Mail.defaults do
      delivery_method :smtp, {
        :port => 25,
        :address => "smtp.sendgrid.net",
        :domain => ENV["SENDGRID_DOMAIN"],
        :authentication => "plain",
        :user_name => ENV["SENDGRID_USERNAME"],
        :password => ENV["SENDGRID_PASSWORD"]
      }
    end

TIP: If you're using sendmail, just comment or remove the configuration file.

### config/config.yml

This is where you configure the notifications that you want to receive

    repos:
      "http://github.com/dabit/dummy_repo":
        "refs/heads/master":
          recipients: [david@crowdint.com, someoneelse@crowdint.com]
        "refs/heads/debug":
          recipients: [david@crowdint.com]
      "http://github.com/defunkt/github":
        "refs/heads/master":
          recipients: [david@crowdint.com]
        "refs/heads/debug":
          recipients: [david@crowdint.com]

## Run with rackup

Configure it to your needs, then run:

    rackup config.ru

## Run on Heroku

A quick way to set this up is by using heroku. Clone or fork the repo, change the settings to match your needs and just:

    heroku create --stack bamboo-ree-1.8.7
    heroku addons:add sendgrid:free
    git push heroku

Run *heroku info*, copy the URL, and configure it to receive your POST hooks on github. And that's it!

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico. 
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!