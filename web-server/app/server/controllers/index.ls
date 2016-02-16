require! \express
router = express.Router!


router.get '/', (req, res, next) ->
  res.render 'index', title: 'SpaceTweet!', asset-port: global.config['asset-port']



module.exports = router
