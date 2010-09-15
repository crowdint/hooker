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
      response = self.config.inspect
      [200, {"Content-Type" => "text/plain", "Content-length" => response.length.to_s}, response]
    end
  end
end