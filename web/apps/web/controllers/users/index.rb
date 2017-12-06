module Web::Controllers::Users
  class Index
    include Web::Action

    def call(params)
	if(!session[:user])
		redirect_to '/'
	end
	 
   end
  end
end
