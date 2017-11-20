# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
get '/users', to: 'users#subsajax'
get '/users', to: 'users#index'
get '/session', to: 'session#failure', as: :sessionfailure
delete '/session/:id', to: 'session#destroy', as: :sessiondestroy
post '/session/new', to: 'session#new', as: :sessionNew
get '/users/signup', to: 'users#signup'
resources :users, only: [:create]
post '/user', to: 'users#create', as: :createUser
get '/user/dashboard', to: 'users#index', as: :dashboard
get '/auth/failure', to: 'session#failure'
get '/auth/singout', to: 'session#destroy'
get '/user/:provider', to: 'session#new'
get '/', to: 'home#index', as: :home
get '/podcasts', to: 'podcasts#index', as: :podcasts
get '/podcasts/:id', to: 'podcasts#show', as: :show
get '/subs/', to: 'users#subs_ajax', as: :subsajax
#get '/podcasts/show/:id', to: 'podcasts#show', as: :show
#get 'podcasts/show/', to: 'show#index'
