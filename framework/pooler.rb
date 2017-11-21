class Pooler
	def initialize(sources: {}, repositories: {}, time: 300)
		@updaters = updaters
		@repositories = repositories
		@time = time
		@subscribers = []
	end

	def pool
		loop do
			updated = {}

			threads = []
			@updaters.each_pair do |source, updater|
				threads << Threads.new { 
					updated[source] = updater.verify(source, 
						repositories[source].last_updated) 
				}
			end
			
			threads.each { |t| t.join }

			data = Set.new

			threads = []
			@updaters.each_pair do |source, updater|
				threads << Threads.new { 
					if updated[source]
						new_data = updater.update(source)
						repositories[source].batch_update(new_data)
						data.merge(new_data)) 
					end
					}		
			end
			
			threads.each { |t| t.join }
			
			if updated.has_value?(true)
				notify_all(data)
			end
			
			sleep @time
		end
	end

	def notify_all(data)
		@subscribers.each do |subscriber|
			subscriber.notify(data)
		end
	end

	def add_subscriber(subscriber)
		@subscribers << subscriber
	end

	def remove_subscriber(subscriber)
		@subscribers.delete(subscriber)
	end
end