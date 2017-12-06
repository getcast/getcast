class PodcastRepository
	def initialize
		@podcasts = Database[:podcasts]
	end

	def each &blk
		@podcasts.each &blk
	end
end