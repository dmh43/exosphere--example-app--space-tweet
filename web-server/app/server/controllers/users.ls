require! \express
router = express.Router!


# GET users listing
router.get '/', (req, res, next) ->
  global.exorelay.send 'users.list', null, (users) ->
    res.render 'users/index', {users}



module.exports = router;
