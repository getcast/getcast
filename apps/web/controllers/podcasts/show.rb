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
    def connection(url, headers, request_options)
      Faraday.new(url: url, headers: headers, request: request_options) do |conn|
        conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
        conn.adapter Faraday.default_adapter
      end
    end

    def start_val
      id = @podcast.id
      url = @podcast.url
      begin
        if not @podcast.cache
          xml = Feedjira::Feed.connection(url).get.body
          @podcast = @repository.update_cache(id, xml)
        else
          headers = {user_agent: Feedjira.user_agent, 
            if_modified_since: @podcast.last_updated.httpdate}
          request_options = {timeout: Feedjira.request_timeout}
          xml = connection(url, headers, request_options).get.body
          if not xml.empty?
            @podcast = @repository.update_cache(id, xml)
          end
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
