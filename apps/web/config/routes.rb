# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
get '/', to: 'home#index'
get '/podcasts', to: 'podcasts#index', as: :podcasts
get '/podcasts/:id', to: 'podcasts#show', as: :show
#get '/podcasts/show/:id', to: 'podcasts#show', as: :show
#get 'podcasts/show/', to: 'show#index'
