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

  def update_cache(id, xml)
    update(id, cache: xml)
    update(id, last_updated: DateTime.now)
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
