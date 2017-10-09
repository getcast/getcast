module Web::Controllers::Podcasts
  class Index
    include Web::Action

    expose :podcasts
    expose :database_valid

    def call(params)
    	@repository = PodcastRepository.new
    	@podcasts = 
            if params[:"search-title"] || params[:"search-desc"] then
                @repository.search(title: params[:"search-title"], description: params[:"search-desc"], limit: 1000, order_by: params[:"search-order-by"].to_sym)
    		elsif params[:"search-all"] then
    			@repository.search(params[:search], limit: 1000, order_by: params[:"search-order-by"].to_sym)
    		else
    			@repository.take(1000)
    		end
    		@database_valid = @repository.any?
    end
  end
end
