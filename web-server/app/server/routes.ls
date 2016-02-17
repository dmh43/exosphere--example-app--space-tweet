module.exports = ({GET, resources}) ->

  GET '/' to: 'home#index'

  resources 'users' only: <[ index new create ]>
