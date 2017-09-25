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
        #xml = Faraday.get(url).body
        #feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
	feed = Feedjira::Feed.fetch_and_parse(url)
	#Feedjira::Feed.add_common_feed_element 'image'
	puts feed
	#puts feed.image.url
      rescue Feedjira::NoParserAvailable, Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "error fetching and parsing url"
      rescue NoMethodError
        puts "missing attributes"
      else
        @episodes = feed.entries.each
	#@image = feed.image.url
      end        
    end
  end
end
