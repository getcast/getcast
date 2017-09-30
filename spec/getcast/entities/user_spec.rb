require 'spec_helper'

describe User do
	before do
		@user = User.new(first_name: "Steven", last_name: "Universe",
				 email: "stevenuniverse@getcast.com", password: Encrypter.generate("gemsRuby"),
				terms_of_service: true )
	end
	it 'password encryption works' do
		assert_instance_of Encrypter, @user.password 
		assert_equal(@user.password,"gemsRuby")		
	end

end
