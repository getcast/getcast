class EpisodeRepository < Hanami::Repository
	self.relation = :episodes

	mapping do
		attribute :id, from: :id
		attribute :podcast_id, from: :podcast_id
		attribute :title, from: :title
		attribute :desc, from: :desc
		attribute :media_url, from: :media_url
		attribute :pub_date, from: :pub_date
		attribute :date_added, from: :date_added
	end

	def get_episodes_by_podcast(podcast_id)
		episodes.where(podcast_id: podcast_id)
	end
end