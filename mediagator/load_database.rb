require_relative 'database'
require 'feedjira'

Database.config \
	adapter: :postgres, \
	user: 'getcast', \
	password: 'marvelouspandaband', \
	host: 'localhost', \
	database: 'getcast_test' \
do
end

def connection(url, headers, request_options)
  Faraday.new(url: url, headers: headers, request: request_options) do |conn|
    conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
    conn.adapter Faraday.default_adapter
  end
end

podcasts = Database[:podcasts]

File.open("new_data.txt") do |file|
	file.each_line do |line|
		line = line.chomp
		headers = {user_agent: Feedjira.user_agent}
    request_options = {timeout: Feedjira.request_timeout}
    xml = connection(line, headers, request_options).get.body
    feed = Feedjira::Feed.parse_with(Feedjira::Parser::ITunesRSS, xml)
    podcasts.insert(title: feed.title, desc: feed.description, feed_url: feed.feed_url || line, image_url: feed.image ? feed.image.url : nil)
  end
end 
