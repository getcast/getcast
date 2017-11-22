require_relative'framework/pooler'
require_relative 'framework/updater'

module Web::Controllers::Mosaic
  class Show
    include Web::Action

    expose :photos

    def call(params)
    #    rep = {}
    #    r = PhotosRepository.new
    #    rep['"found face"'] = r

    #    up = {}
    #    u = Updater.new
    #    up['"found face"'] = u

    #    s = Subscriber.new

    #    pooler = Pooler.new(up, rep)

    #    pooler.add_subscriber(s)

    #    pooler.pool

        repository = PhotosRepository.new
        @photos = repository.take(100)
    end
  end
end
