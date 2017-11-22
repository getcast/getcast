module Web::Controllers::Podcasts
  class Index
    include Web::Action

    expose :podcasts
    expose :database_valid

    def call(params)
        order_by =
            if params[:"search-order-by"] == "most-watched"
                :listens
            else
                :last_updated
            end

    	@repository = PodcastRepository.new
    	@podcasts = 
            if params[:"search-title"] || params[:"search-desc"]
                @repository.search(title: params[:"search-title"], description: params[:"search-desc"], limit: 1000, order_by: order_by)
    		elsif params[:"search-all"]
    			@repository.search(params[:search], limit: 1000, order_by: order_by)
    		else
    			@repository.take(1000)
    		end
    	@database_valid = @repository.any?
    end
  end
end
