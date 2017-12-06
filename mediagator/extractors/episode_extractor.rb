require 'feedjira'

class EpisodeExtractor < Extractor
	def verify podcast
		return true if podcast[:last_updated].nil?

		headers = {user_agent: Feedjira.user_agent, 
          if_modified_since: podcast[:last_updated].httpdate}
    request_options = {timeout: Feedjira.request_timeout}
    xml = connection(podcast[:feed_url], headers, request_options).get.body
    not xml.empty?
	end

	def extract podcast
    return [] if podcast[:feed_url].nil?

    headers = {user_agent: Feedjira.user_agent}
    unless podcast[:last_updated].nil?
      headers[:if_modified_since] = podcast[:last_updated].httpdate
    end

    request_options = {timeout: Feedjira.request_timeout}
    xml = connection(podcast[:feed_url], headers, request_options).get.body
    
    feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)

    podcast[:last_updated] = DateTime.now
    Database[:podcasts].where(id: podcast[:id]).update(last_updated: podcast[:last_updated])

    new_episodes = []
    feed.entries.each do |episode|
    	new_episodes << { podcast_id: podcast[:id],
                        title: episode.respond_to?(:title) ? episode.title : nil,
                        desc: episode.respond_to?(:description) ? episode.description : nil,
                        media_url: episode.respond_to?(:enclosure_url) ? episode.enclosure_url : nil,
                        pub_date: episode.respond_to?(:published) ? episode.published : nil }
   	end

   	new_episodes 
	end

	private def connection(url, headers, request_options)
    Faraday.new(url: url, headers: headers, request: request_options) do |conn|
      conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
      conn.adapter Faraday.default_adapter
    end
  end
end