class HomeController

  ({@send}) ->


  index: (req, res) ->
    @send 'tweets.list', {}, (tweets) ->
      res.render 'index', tweets



module.exports = HomeController
