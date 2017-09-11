#require 'feedjira'
require 'rss'
require 'open-uri'

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
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items
      end
    end
  end
end
