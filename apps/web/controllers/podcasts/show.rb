module Web::Controllers::Podcasts
  class Show
    include Web::Action

    expose :podcast
    expose :episodes
    expose :image
    def call(params)	
    	@podcast = PodcastRepository.new.find(params[:id])
    	@episodes
	@image
	start_val
    end
    
    private 
    def start_val
      url = @podcast.url
      begin
	xml = Feedjira::Feed.connection(url).get.body
        feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
      rescue Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "error fetching and parsing url"
      else
        @episodes = feed.entries.each
	@image = feed.image ? feed.image.url : ""
      end        
    end
  end
end
