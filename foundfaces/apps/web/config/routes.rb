# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/mosaic/', to: 'mosaic#show'
get '/mosaic/delete/:id', to: 'mosaic#delete', as: :delete_photo
