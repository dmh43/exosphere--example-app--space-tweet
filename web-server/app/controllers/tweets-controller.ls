class TweetsController

  ({@send}) ->


  create: (req, res) ->
    @send 'tweets.create', content: req.body.content, owner_id: '1', ->
      res.redirect '/'



module.exports = TweetsController

