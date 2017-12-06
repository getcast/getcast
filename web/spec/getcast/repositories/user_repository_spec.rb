require 'spec_helper'

describe UserRepository do
  # place your tests here
  before do
  	@user = UserRepository.new.create(first_name: "Foomartin", last_name: "Duckinson", email: "foo2000@duck.com")
  end

  after do
  	UserRepository.new.delete(@user.id)
  end

  it 'find user "Foomartin" by email "foo2000@duck.com"' do
  	rep = UserRepository.new
  	email = "foo2000@duck.com"
  	user = rep.find_by_email(email)
  	user.id.must_equal @user.id
  end
end
