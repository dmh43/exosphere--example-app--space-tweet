module.exports = ({GET, POST, DELETE, resources}) ->

  GET '/' to: 'home#index'

  resources 'tweets' only: <[ create ]>
  resources 'users'

  GET '/login' to: 'sessions#index' as: 'login'
  POST '/login' to: 'sessions#create' as: 'createSession'
  POST '/logout' to: 'sessions#destroy' as: 'destroySession'
