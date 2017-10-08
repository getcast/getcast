require_relative 'podcast_service'

class PodcastRepository < Hanami::Repository
  include PodcastService

  def take(limit)
    podcasts
      .order(Sequel.desc(:updated_at))
      .limit(limit)
  end

  def any?
    podcasts.count > 0
  end

  def update_cache(id, xml, feed)
    update(id, cache: xml)
    if feed.last_built
      begin
        time = Time.httpdate(feed.last_built.chomp('+0000')+'GMT')
      rescue ArgumentError # last_built not a valid string
        entry = update(id, last_updated: DateTime.now)
      else
        entry = update(id, last_updated: time)
      end
    else
      entry = update(id, last_updated: DateTime.now)
    end
    entry
  end

  def connection(url, headers, request_options)
    Faraday.new(url: url, headers: headers, request: request_options) do |conn|
      conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
      conn.adapter Faraday.default_adapter
    end
  end

  def get_feed(id)
    feed = nil
    podcast = find(id)
    if !podcast
      return feed
    end

    begin
      if !podcast.cache
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
      raise
    end

    feed
  end

  @@ATTRS = [:url, :title, :description].freeze
  def search(*args, **kwargs)
    if not kwargs.empty?
    then  
      queries = true
      kwargs.each_pair do |attribute, value|
        raise "invalid keyword argument '#{attribute}' for class Podcast" unless @@ATTRS.include?(attribute)
        queries = Sequel.&(queries, Sequel[attribute].like("%#{value}%", case_insensitive: true))
      end

      podcasts.where(queries)
      
    elsif not args.empty?
    then  
      raise "invalid number of arguments (expected 1, got #{args.length})" unless args.length == 1 
  
      queries = false
      @@ATTRS.each do |attribute|
        queries = Sequel.|(queries, Sequel[attribute].like("%#{args[0]}%", case_insensitive: true))
      end
      
      podcasts.where(queries)
    end
  end
end
