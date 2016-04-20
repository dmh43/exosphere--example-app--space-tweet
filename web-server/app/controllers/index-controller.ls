require! {
  'prelude-ls' : {compact, map, unique}
}


class HomeController

  ({@send}) ->


  index: (req, res) ->
    @send 'tweets.list', {}, (tweets-result) ->
      user-ids = tweets-result.tweets |> map (.owner_id?.to-string!)
                                      |> unique
                                      |> compact
      @send 'users.list', user-ids, (users-result) ->
        res.render 'index', tweets-result



module.exports = HomeController
