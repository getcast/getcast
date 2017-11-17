class Pooler
	def initialize(sources: {}, time: 300)
		@sources = sources
		@time = time
		@subscribers = []
	end

	def pool
		loop do
			datas = Set.new
			threads = []
			
			@sources.each_pair do |source, updater|
				threads << Threads.new { datas.merge(updater.update(source)) }
			end
			
			threads.each { |t| t.join }
			
			notify_all(datas)
			
			sleep @time
		end
	end

	def notify_all(datas)
		@subscribers.each do |subscriber|
			subscriber.notify(datas)
		end
	end

	def add_subscriber(subscriber)
		@subscribers << subscriber
	end

	def remove_subscriber(subscriber)
		@subscribers.delete(subscriber)
	end
end