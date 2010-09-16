require 'test/test_helper'

class HookerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @hooker
  end

  def setup
    @hooker    = Rack::Hooker.new
    @hooker.stubs(:notify)
    @request   = Rack::MockRequest.new(@hooker)
  end

  def test_setup
    assert_not_nil @hooker
    assert_not_nil @request
  end

  def test_success_response
    assert_equal(@request.post("/").status, 200)
  end

  def test_read_configuration
    assert_not_nil(@hooker.config["repos"])
    assert_not_nil(@hooker.config["repos"]["http://github.com/defunkt/github"])
    assert_not_nil(@hooker.config["repos"]["http://github.com/defunkt/github"]["refs/heads/master"])
    assert_kind_of(Hash, @hooker.config["repos"]["http://github.com/defunkt/github"]["refs/heads/master"])
    assert_not_nil(@hooker.config["repos"]["http://github.com/defunkt/github"]["refs/heads/master"]["recipients"])
    assert_kind_of(Array, @hooker.config["repos"]["http://github.com/defunkt/github"]["refs/heads/master"]["recipients"])
  end

  def test_regular_push
    assert_equal(post("/", github_sample_post).body, "NOTIFY")
  end
  
  def test_forced_push
    assert_equal(post("/", failing_post).body, "NOTIFY")    
  end
end
