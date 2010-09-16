require "rack"
require "rack/request"
require "rack/response"
require 'yaml'
require 'json'
require 'config/mail'

module Rack
  class Hooker
    attr_accessor :config
    def initialize
      self.config = YAML.load_file("config/config.yml")
    end

    def call(env)
      request = Rack::Request.new(env)
      payload = request.params["payload"] || ""
      response = "NOTHING TO DO"
      unless payload.empty?
        params = JSON.load(payload)

        # Look for the repo on config.yml
        repo = self.config["repos"][params["repository"]["url"]]

        # If repo found, look for the branch on config.yml
        branch = repo[params["ref"]] if repo

        # If branch found, and has recipients, notify
        if branch && branch["recipients"]
          branch["recipients"].each do |r|
            subject = %{#{pusher_name(params)} pushed to #{params["ref"]} on #{params["repository"]["url"]}}
            body = create_body(params)
            notify(r, subject, body)
            response = "NOTIFY"
          end
        end
      end

      [200, {"Content-Type" => "text/plain", "Content-length" => response.length.to_s}, response]
    end

    def notify(recipient, subject, body)
      from = self.config["mailfrom"] || "noone@noplace.com"
      mail = Mail.new do
        from from
        to recipient
        content_type 'text/html; charset=UTF-8'
        subject subject
        body body
      end

      mail.deliver!
      mail
    end

    def create_body(params)
      body = ""
      if params["forced"] == true
        body = %{<a href="#{params["compare"]}">Forced push</a></br>}
      else
        for commit in params["commits"]
          body = %{#{body} <a href="#{commit["url"]}">#{commit["id"]}</a> - #{commit["message"]}<br/>}
        end
      end
      body
    end

    def pusher_name(params)
      if params["pusher"]
        params["pusher"]["name"]
      else
        "Test"
      end
    end
  end
end