module Web::Controllers::Users
  class Create
    include Web::Action
    include Hanami::Validations::Form

    expose :user
	params do
		required(:user).schema do
			required(:first_name).filled(:str?)
			required(:last_name).filled(:str?)
			required(:email).filled(:str?, format?: /\A.+@.+\z/)
			required(:password).filled(:str?)
			required(:terms_of_service).filled(:bool?)
		end
	end
    
    def call(params)
	if params.valid?
		@user = UserRepository.new.create(params[:user])
		#Mailers::ConfirmEmail.deliver(user: @user)	
#	redirect_to 
	else
		self.status = 422
	end
    end
  end
end
