module Web::Controllers::Users
  class Unsubscribe
    include Web::Action

    def call(params)
	if session[:user]
		sub = SubsRepository.new
		r = sub.find_subs(session[:user].id,params[:podcastid] )
		sub.delete(r.id)
	end
    end

  end
end
