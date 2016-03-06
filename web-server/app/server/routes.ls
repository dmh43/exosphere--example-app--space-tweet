module.exports = ({GET, resources}) ->

  GET '/' to: 'home#index'

  resources 'tweets' only: <[ create ]>
  resources 'users' only: <[ index new create show ]>
