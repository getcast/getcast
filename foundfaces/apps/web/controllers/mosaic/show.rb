module Web::Controllers::Mosaic
  class Show
    include Web::Action

    expose :photos

    def call(params)
	@photos = PhotosRepository.new.all(500)

    end
  end
end
