require 'set'

class Pooler
	def initialize(sources: {}, time: 300)
		@subscribers = Set.new
		@sources = sources
		@time = time
	end

	def pool
		loop do
			@sources.each_pair do |source, extractor|
				if extractor.verify(source)
					extractor.update(source)
					notify_all
				end
			end
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