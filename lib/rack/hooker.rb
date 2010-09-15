require "rack"
require "rack/request"
require "rack/response"
require 'yaml'

module Rack
  class Hooker
    attr_accessor :config
    def initialize
      self.config = YAML.load_file("config.yml")
    end

    def call(env)
      input = env["rack.input"].read
      response = "NOTHING TO DO"
      unless input.empty?
        params = YAML.load(input)
        repo = self.config["repos"][params["repository"]["url"]]
        branch = repo[params["ref"]] if repo
        if branch && branch["recipients"]
          branch["recipients"].each do |r|
            # INSERT CODE THAT SENDS THE NOTIFICATION HERE
            response = "NOTIFY"
          end
        end
      end

      [200, {"Content-Type" => "text/plain", "Content-length" => response.length.to_s}, response]
    end
  end
end