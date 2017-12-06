class UserRepository < Hanami::Repository
	self.relation = :users

	mapping do
		attribute :id, from: :id
		attribute :username, from: :username
		attribute :email, from: :email
		attribute :last_login, from: :last_login
		attribute :registration_date, from: :registration_date
	end
end