require 'set'

class Pooler
	def initialize(sources: {}, time: 300)
		@subscribers = Set.new
		@sources = sources
		@time = time
	end

	def pool
		loop do
			threads = []
			@sources.each_pair do |source, extractor|
				if extractor.verify(source) 
					threads << Thread.new {				
						extractor.update(source)
					}
				end
			end
			threads.each { |t| t.join }
			notify_all if threads
			sleep @time
		end
	end

	def notify_all
		@subscribers.each do |subscriber|
			subscriber.notify
		end
	end

	def add_subscriber(subscriber)
		@subscribers << subscriber
	end

	def remove_subscriber(subscriber)
		@subscribers.delete(subscriber)
	end
end