require! {
  '../middleware/ensure-authenticated'
  'exprestive': {BaseController}
}


class HomeController extends BaseController

  ({@send}) ->
    @useMiddleware ensure-authenticated


  index: (req, res) ->
    @send 'tweets.list', {}, (tweets) ->
      res.render 'index', tweets



module.exports = HomeController
