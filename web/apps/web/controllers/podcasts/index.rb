module Web::Controllers::Podcasts
  class Index
    include Web::Action

    expose :podcasts

    def call(params)
    	repository = PodcastRepository.new
    	@podcasts = repository.take(1000)
    end
  end
end
