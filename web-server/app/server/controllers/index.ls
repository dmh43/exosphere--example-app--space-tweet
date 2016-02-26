class HomeController

  ({@send}) ->


  index: (req, res) ->
    @send 'tweets.list', owner_id: '1', (tweets) ->
      res.render 'index', tweets



module.exports = HomeController
