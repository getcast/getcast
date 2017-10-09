require 'spec_helper'
require_relative '../../../../apps/web/controllers/session/new'

describe Web::Controllers::Session::New do
  let(:action) { Web::Controllers::Session::New.new }
  let(:params) { Hash[userSession: Hash[email: "diddle@doodle.com", password: "aaaa"]] }

  before do
  	@user = UserRepository.new.create(first_name: "Diddledy", last_name: "McDiddledoo", email: "diddle@doodle.com", password: "$2y$10$XqLpMYaX544E1KNQIg7YguP3gXAj2/65Eip1E.qEKP9olSIFopWtq")
  end

  after do
  	UserRepository.new.delete(@user.id)
  end

  it 'is successful' do
   	response = action.call(params)
   	response[0].must_equal 302
  end
end
