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
      \"ref\": \"refs/heads/master\",
      \"pusher\":{\"name\":\"dabit\",\"email\":\"david@crowdint.com\"}
      }"
  }
end

def failing_post
  {"payload" => "
    {\"repository\":{
      \"url\":\"http://github.com/dabit/dummy_repo\",
      \"has_wiki\":true,\"description\":\"\",\"open_issues\":0,
      \"homepage\":\"\",\"has_issues\":true,\"fork\":false,
      \"pushed_at\":\"2010/09/15 23:20:18 -0700\",\"watchers\":1,
      \"private\":false,\"created_at\":\"2010/09/15 14:22:35 -0700\",
      \"has_downloads\":true,
      \"owner\":{\"name\":\"dabit\",\"email\":\"david@crowdint.com\"},
      \"name\":\"dummy_repo\",\"forks\":0},
      \"before\":\"3f1e0422f23ea1d019c1a7602ae29be992540786\",
      \"after\":\"7a42488f6f80a797e4aab6ee3124429d582be555\",
      \"ref\":\"refs/heads/master\",
      \"compare\":\"http://github.com/dabit/dummy_repo/compare/3f1e042...7a42488\",
      \"forced\":true,\"commits\":[],
      \"pusher\":{\"name\":\"dabit\",\"email\":\"david@crowdint.com\"}}"}
end