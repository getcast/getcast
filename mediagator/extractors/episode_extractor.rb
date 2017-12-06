require 'feedjira'

class EpisodeExtractor < Extractor
	def verify podcast
		true if podcast.last_updated.nil?

		headers = {user_agent: Feedjira.user_agent, 
          if_modified_since: podcast.last_updated.httpdate}
    request_options = {timeout: Feedjira.request_timeout}
    xml = connection(podcast.url, headers, request_options).get.body
    not xml.empty?
	end

	def extract podcast
		headers = {user_agent: Feedjira.user_agent, 
          if_modified_since: podcast.last_updated.httpdate}
    request_options = {timeout: Feedjira.request_timeout}
    xml = connection(podcast.url, headers, request_options).get.body
    feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)

    Database[:podcasts].where(id: podcast.id).update(last_updated: DateTime.now)

    new_episodes = []
    feed.entries.each do |episode|
    	new_episodes << { podcast_id: podcast.id, title: episode.title, desc: episode.description, media_url: episode.enclosure_url, pub_date: episode.published }
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