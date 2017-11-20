module Web::Controllers::Users
  class SubsAjax
    include Web::Action


    def call(params)
	if session[:user]
		r = SubsRepository.new.create(user_id:session[:user].id, podcast_id: params[:podcastid] )
	end
    end

    def subscribe(userid, podcastid)
    end
  end
end
