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
	def initialize
		@subscribers = []
	end

	def sources *srcs
		@sources = srcs
	end

	def extractor extractor_cls
		@extractor = extractor_cls.new
	end

	def repository repository_cls
		@repository = repository_cls.new
	end

	def subscribers *subscriber_clss
		subscriber_clss.each do |cls|
			@subscribers << cls.new
		end  
	end

	def build
		Pooler.new(@sources, @extractor, @repository, @subscribers)
	end
end
