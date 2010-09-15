require 'rubygems'
require "test/unit"
require "lib/rack/hooker"
require "rack/mock"

class HookerTest < Test::Unit::TestCase
  def setup
    @hooker = Rack::Hooker.new
    @request = Rack::MockRequest.new(@hooker)
  end

  def test_setup
    assert_not_nil @hooker
    assert_not_nil @request
  end

  def test_success_response
    assert_equal(@request.get("/").status, 200)
  end

  def test_read_configuration
    assert_not_nil(@hooker.config["repos"])
    assert_not_nil(@hooker.config["repos"]["http://www.gitrepo.com"])
    assert_not_nil(@hooker.config["repos"]["http://www.gitrepo.com"]["ref"])
    assert_not_nil(@hooker.config["repos"]["http://www.gitrepo.com"]["recipients"])
    assert_kind_of(Array, @hooker.config["repos"]["http://www.gitrepo.com"]["recipients"])
  end
end
