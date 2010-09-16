require 'rubygems'
require "test/unit"
require "lib/rack/hooker"
require "rack/mock"
require 'rack/test'

class HookerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @hooker
  end

  def setup
    @hooker    = Rack::Hooker.new
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

  def test_github
    assert_equal(post("/", github_sample_post).body, "NOTIFY")
  end

  def github_sample_post
    {"payload" =>"
      {
        \"before\": \"5aef35982fb2d34e9d9d4502f6ede1072793222d\",
        \"repository\": {
        \"url\": \"http://github.com/defunkt/github\",
        \"name\": \"github\",
        \"description\": \"You're lookin' at it.\",
        \"watchers\": 5,
        \"forks\": 2,
        \"private\": 1,
        \"owner\": {
        \"email\": \"chris@ozmm.org\",
        \"name\": \"defunkt\"
      }
      },
      \"commits\": [
      {
        \"id\": \"41a212ee83ca127e3c8cf465891ab7216a705f59\",
        \"url\": \"http://github.com/defunkt/github/commit/41a212ee83ca127e3c8cf465891ab7216a705f59\",
        \"author\": {
        \"email\": \"chris@ozmm.org\",
        \"name\": \"Chris Wanstrath\"
        },
        \"message\": \"okay i give in\",
        \"timestamp\": \"2008-02-15T14:57:17-08:00\",
        \"added\": [\"filepath.rb\"]
        },
        {
          \"id\": \"de8251ff97ee194a289832576287d6f8ad74e3d0\",
          \"url\": \"http://github.com/defunkt/github/commit/de8251ff97ee194a289832576287d6f8ad74e3d0\",
          \"author\": {
          \"email\": \"chris@ozmm.org\",
          \"name\": \"Chris Wanstrath\"
          },
          \"message\": \"update pricing a tad\",
          \"timestamp\": \"2008-02-15T14:36:34-08:00\"
        }
        ],
        \"after\": \"de8251ff97ee194a289832576287d6f8ad74e3d0\",
        \"ref\": \"refs/heads/master\"
        }"
    }
  end
end
