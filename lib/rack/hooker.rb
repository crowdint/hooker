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
      input = request.params["payload"] || ""
      response = "NOTHING TO DO"
      unless input.empty?
        params = JSON.load(input)
        repo = self.config["repos"][params["repository"]["url"]]
        branch = repo[params["ref"]] if repo
        if branch && branch["recipients"]
          branch["recipients"].each do |r|
            subject = %{#{params["commits"].first["author"]["name"]} pushed to #{params["ref"]} on #{params["repository"]["url"]}}
            body = create_body(params["commits"])
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

    def create_body(commits)
      body = ""
      for commit in commits
        body = %{#{body} <a href="#{commit["url"]}">#{commit["id"]}</a></br>}
      end
      body
    end
  end
end