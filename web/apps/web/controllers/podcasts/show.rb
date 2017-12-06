module Web::Controllers::Podcasts
  class Show
    include Web::Action

    expose :episodes
    expose :podcast

    def call(params)
    	podcast_repository = PodcastRepository.new
    	@podcast = podcast_repository.find(params[:id])
    	
    	episode_repository = EpisodeRepository.new
    	@episodes = episode_repository.get_episodes_by_podcast(params[:id])
    end
  end
end
