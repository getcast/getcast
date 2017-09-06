module Web::Controllers::Podcasts
  class Index
    include Web::Action

    expose :podcasts

    def call(params)
    	@podcasts = PodcastRepository.new
    end
  end
end
