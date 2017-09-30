class User < Hanami::Entity
	attributes do
		attribute :id,  Types::Int
		attribute :first_name, Types::String
		attribute :last_name, Types::String
		attribute :email, Types::String
		attribute :password, Type::String
		attribute :encrypted_password, Type::String
		attribute :terms_of_service, Types::Bool
		attribute :created_at,         Types::Time
		attribute :updated_at,         Types::Time
	end

	def password
		Password.new(super)
	end
end
