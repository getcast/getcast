class Pooler
	def initialize(extractor, repository, time: 300)
		@extractor = extractor
		@repository = repository
		@time = time
	end

	def pool(sources)
		loop do
			threads = []
			sources.each do |source|
				t = Thread.new do
					if @extractor.verify(source)
						new_data = @extractor.extract(source)
						@repository.batch_update(new_data)
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
