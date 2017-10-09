module Updater

  def update_cache(id, xml, feed)
    update(id, cache: xml)
    if feed.last_built
      begin
        time = Time.httpdate(feed.last_built.chomp('+0000')+'GMT')
      rescue ArgumentError # last_built not a valid string
        entry = update(id, last_updated: DateTime.now)
      else
        if time
          entry = update(id, last_updated: time)
        else
          entry = update(id, last_updated: DateTime.now)
        end
      end
    else
      entry = update(id, last_updated: DateTime.now)
    end
    entry
  end

  private def connection(url, headers, request_options)
    Faraday.new(url: url, headers: headers, request: request_options) do |conn|
      conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
      conn.adapter Faraday.default_adapter
    end
  end

  def update(podcast)
    if podcast
      begin
        if !podcast.cache || !podcast.last_updated
          xml = Feedjira::Feed.connection(podcast.url).get.body
          feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
          update_cache(id, xml, feed)
        else
          headers = {user_agent: Feedjira.user_agent, 
            if_modified_since: podcast.last_updated.httpdate}
          request_options = {timeout: Feedjira.request_timeout}
          xml = connection(podcast.url, headers, request_options).get.body
          if not xml.empty?
            feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
            update_cache(id, xml, feed)
          else
            feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, podcast.cache)
          end
        end
      rescue Feedjira::FetchFailure, Faraday::Error, Zlib::DataError
        puts "Error fetching and parsing url #{podcast.url}"
      end
    end
  end
end


repository = PodcastRepository.new

loop do
  repository.all do |podcast|
    Updater::update(podcast)
  end
end