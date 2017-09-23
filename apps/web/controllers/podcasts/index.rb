module Web::Controllers::Podcasts
  class Index
    include Web::Action

    expose :podcasts
    expose :database_valid

    def call(params)
    	@repository = PodcastRepository.new
    	@podcasts =
    		if params[:search] then
    			@repository.search(params[:search])
    		else
    			@repository.take(1000)
    		end
    		@database_valid = @repository.any?
    end
  end
end
