class User < Hanami::Entity
	EMAIL_FORMAT = /\@/
	attributes do
		attribute :id,  Types::Int
		attribute :first_name, Types::String
		attribute :last_name, Types::String
		attribute :email, Types::String.constrained(format: EMAIL_FORMAT)
		attribute :password, Types::String
		attribute :encrypted_password, Types::String
		attribute :terms_of_service, Types::Bool
		attribute :created_at,         Types::Time
		attribute :updated_at,         Types::Time
	end

	def password
		Encrypter.new(super)
	end
end
