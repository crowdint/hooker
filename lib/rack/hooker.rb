require "rack"
require "rack/request"
require "rack/response"

module Rack
  class Hooker
    def call(env)
      response = "Hello world"
      [200, {"Content-Type" => "text/plain", "Content-length" => response.length.to_s}, response]
    end
  end
end