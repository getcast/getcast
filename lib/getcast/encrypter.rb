require 'bcrypt'

class Encrypter
 
	DEFAULT_COST = BCrypt::Engine.cost

	def self.generate(input, cost: DEFAULT_COST)
		BCrypt::Password.create(input, cost: cost)
	end

	def initialize(encrypted_password)
		@password = BCrypt::Password.new(encrypted_password)
	end

	def ==(other)
		@password == other
	end
end
