class Application
	def self.config &blk
		self.instance_eval &blk
	end

	def self.pool &blk
		builder = PoolerBuilder.new
		builder.instance_eval &blk
		@@poolers << builder.build
	end
end

class PoolerBuilder
	def sources *srcs
		@sources = srcs
	end

	def extractor extractor_cls
		@extractor_cls = extractor_cls
	end

	def repository repository_cls
		@repository_cls = repository_cls
	end

	def build
		Pooler.new(@sources, @extractor_cls, @repository_cls)
	end
end
