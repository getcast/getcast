class Pooler
	def initialize(updaters, repositories, time: 300)
		@updaters = updaters
		@repositories = repositories
		@time = time
		@subscribers = []

	end

	def pool
		loop do
			updated = {}

			@updaters.each_pair do |source, updater|
				updated[source] = updater.verify(source, 
					@repositories[source].last_updated) 
			end
			data = Set.new

			@updaters.each_pair do |source, updater|
				if updated[source]
					new_data = updater.update(source, 
						@repositories[source].last_updated)
					@repositories[source].batch_update(new_data)
					data.merge(new_data) 
				end	
			end

			if updated.has_value?(true)
				notify_all(data)
			end

			# BREAKING !!!
			break			
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
