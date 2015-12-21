require! {
  \express
  '../../../package.json' : config
}

router = express.Router!

router.get '/', (req, res, next) ->
  res.render 'index', config


module.exports = router
