require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/create'

describe Web::Controllers::Users::Create do
  let(:action) { Web::Controllers::Users::Create.new }
  after do
    UserRepository.new.clear
  end
  describe 'with valid params' do
    let(:params) {Hash[user: {first_name: 'Duck', last_name: 'Dodgers', email: 'duckdodgers@getcast.com',password: 'duck@123', terms_of_service: true }]}
	it 'creates a new user'do
		action.call(params)
		action.user.id.wont_be_nil
	end
  end
  describe 'with invalid params' do
      let(:params) { Hash[book: {}] }
  
      it 'should throw 422' do
        response = action.call(params)
        response[0].must_equal 422
      end
  end
end
