class Application
	def self.config
		yield
	end

	def self.sources *srcs
		@@sources = srcs
	end

	def self.extractor extractor_cls
		@@extractor_cls = extractor_cls
	end

	def self.repository repository_cls
		@@repository_cls = repository_cls
	end

	def self.run
		pooler = Pooler.new(@@extractor_cls.new, @@repository_cls.new)
		pooler.pool(@@sources)
	end
end