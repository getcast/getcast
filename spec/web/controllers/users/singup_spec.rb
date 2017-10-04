require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/singup'

describe Web::Controllers::Users::Singup do
  let(:action) { Web::Controllers::Users::Singup.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
