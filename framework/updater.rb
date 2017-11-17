class Updater
	def initialize(repository, notifier)
		@repository = repository
	end

	def verify(source)
		raise "not implemented"
	end

	def update(source)
		datas = verify(source)
		@repository.batch_update(datas) if datas
		datas
	end
end