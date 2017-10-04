module Web::Controllers::Podcasts
  class Show
    include Web::Action

    expose :podcast
    expose :episodes
    expose :image_url
    expose :error
    def call(params)	
    	@podcast = PodcastRepository.new.find(params[:id])
    	@episodes
	@image_url
	start_val
    end
    
    private 
    def start_val
      url = @podcast.url
      begin
	xml = Feedjira::Feed.connection(url).get.body
        feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
      rescue Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "Error fetching and parsing url #{url}"
      else
        @episodes = feed.entries.each
	@image_url = feed.image ? feed.image.url : ""
        #puts @image_url.class
      end        
    end
  end
end
