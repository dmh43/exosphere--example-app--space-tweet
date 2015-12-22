debug = require('debug')('users:create')


module.exports = ({name}, response, {db}) ->
  debug "creating user #{name}"
