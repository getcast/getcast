class Pooler
	def initialize(extractors, repositories, time: 300)
		@extractors = extractors
		@repositories = repositories
		@time = time
	end

	def pool
		loop do
			@extractors.each_pair do |source, extractor|
				if extractor.verify(source)
					new_data = extractor.extract(source)
					@repositories[source].each do |repository|
						repository.batch_update(new_data)
					end
				end
			end

			sleep @time
		end
	end
end
