module Web::Controllers::Show
  class Index
    include Web::Action
     expose :pod
    def call(params)	
	pod = PodcastsRepository.get_by_id(params[:id])
    end
  end
end
