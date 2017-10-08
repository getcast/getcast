# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
get '/session', to: 'session#failure', as: :sessionfailure
delete '/session/:id', to: 'session#destroy', as: :sessiondestroy
get '/session/new', to: 'session#new', as: :sessionNew
get '/users/singup', to: 'users#singup'
resources :users, only: [:create]
post '/user', to: 'users#create', as: :createUser
get '/auth/failure', to: 'session#failure'
get '/auth/singout', to: 'session#destroy'
get '/user/:provider', to: 'session#new'
get '/', to: 'home#index'
get '/podcasts', to: 'podcasts#index', as: :podcasts
get '/podcasts/:id', to: 'podcasts#show', as: :show
#get '/podcasts/show/:id', to: 'podcasts#show', as: :show
#get 'podcasts/show/', to: 'show#index'
