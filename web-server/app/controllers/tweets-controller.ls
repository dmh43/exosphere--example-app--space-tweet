require! {
  '../middleware/ensure-authenticated'
  'exprestive': {BaseController}
}


class TweetsController extends BaseController

  ({@send}) ->
    @useMiddleware ensure-authenticated


  create: (req, res) ->
    @send 'tweets.create', content: req.body.content, owner_id: '1', ->
      res.redirect '/'



module.exports = TweetsController

