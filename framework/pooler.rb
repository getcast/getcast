class Pooler
	def initialize(extractors, repositories, time: 300)
		@extractors = extractors
		@repositories = repositories
		@time = time
	end

	def pool
		loop do
			threads = []
			@extractors.each_pair do |source, extractor|
				t = Thread.new do
					if extractor.verify(source)
						new_data = extractor.extract(source)
						@repositories[source].each do |repository|
							repository.batch_update(new_data)
						end
					end
				end
				t.run
				threads << t
			end

			threads.each do |t|
				t.join
			end

			sleep @time
		end
	end
end
