module Web::Controllers::Podcasts
  class Show
    include Web::Action

    expose :podcast
    expose :episodes
    expose :image_url
    expose :error
    def call(params)
      @repository = PodcastRepository.new
    	@podcast = PodcastRepository.new.find(params[:id])
    	@episodes
    	@image_url
    	start_val
    end

    def start_val
      id = @podcast.id
      url = @podcast.url
      feed = @repository.get_feed(id)
      if feed
        @podcast = @repository.find(id)
        @episodes = feed.entries.each
        @image_url = feed.image ? feed.image.url : ""
      end        
    end
  end
end
