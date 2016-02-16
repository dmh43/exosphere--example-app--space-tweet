require! \express
router = express.Router!


# GET users listing
router.get '/', (req, res, next) ->
  global.exorelay.send 'users.list', null, (users) ->
    res.render 'users/index', {users}

router.get '/new', (req, res, next) ->
  res.render 'users/new'


module.exports = router;
