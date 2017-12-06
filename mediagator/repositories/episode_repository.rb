class EpisodeRepository < Repository
	def initialize
		@episodes = Database[:episodes]
	end

	def batch_update new_episodes
		new_episodes.each do |episode|
			@episodes.insert(episode)
		end
	end
end