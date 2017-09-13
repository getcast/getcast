module Web::Controllers::Podcasts
  class Show
    include Web::Action

    expose :podcast
    expose :episodes

    def call(params)	
    	@podcast = PodcastRepository.new.find(params[:id])
    	@episodes = list_episodes
    end
    
    private 
    def list_episodes
      url = @podcast.url
      begin
        xml = Faraday.get(url).body
        feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
        feed.entries.each do |episode|
          puts episode.title
          puts episode.summary
          puts episode.enclosure_url
        end
      rescue Feedjira::NoParserAvailable, Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "error fetching and parsing url"
      rescue NoMethodError
        puts "missing attributes"
      else
        feed.entries.each
      end        
    end
  end
end
