class PodcastRepository < Hanami::Repository
	self.relation = :podcasts

	mapping do
		attribute :id, from: :id
		attribute :title, from: :title
		attribute :desc, from: :desc
		attribute :feed_url, from: :feed_url
		attribute :image_url, from: :image_url
		attribute :last_updated, from: :last_updated
		attribute :date_added, from: :date_added
	end

	def take(limit)
		podcasts.order{date_added.desc}.limit(limit)
	end
end