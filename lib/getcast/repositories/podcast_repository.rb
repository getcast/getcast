class PodcastRepository < Hanami::Repository
  def take(limit)
    podcasts
      .order(Sequel.desc(:updated_at))
      .limit(limit)
  end

  def any?
    podcasts.count > 0
  end
end
