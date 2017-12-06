class PodcastRepository
	def initialize
		@podcasts = Database[:podcasts]
	end

	def each
		@podcasts.each
	end
end