module Web::Controllers::Session
  class New
    include Web::Action

    def call(params)
	data = params[:userSession]
	if(@userTry = UserRepository.new.find_by_email(data[:email]))
	  if(@userTry.password == data[:password])
	#	self.body = UserRepository.new.find(12)
		puts @userTry.class
		puts @userTry.id
		puts data
		session[:user] =  @userTry
	 	redirect_to "/user" 
	  else
		redirect_to "/" 
	  end
	end
#      self.body = params
    end
  end
end
