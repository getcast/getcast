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
    
    private 
    def start_val
      url = @podcast.url
      begin
        if not @podcast.cache
          xml = Feedjira::Feed.connection(url).get.body
          @podcast = @repository.update(@podcast.id, cache: xml)
        end
        feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, @podcast.cache)
      rescue Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "Error fetching and parsing url #{url}"
      else
        @episodes = feed.entries.each
        @image_url = feed.image ? feed.image.url : ""
      end        
    end
  end
end
