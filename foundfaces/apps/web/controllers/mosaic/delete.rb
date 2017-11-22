module Web::Controllers::Mosaic
  class Delete
    include Web::Action

    def call(params)
    	id = params[:id]
    	repository = PhotosRepository.new
    	repository.delete(id)

    	redirect_to "/mosaic"
    end
  end
end
