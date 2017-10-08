require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/index'

describe Web::Controllers::Users::Index do
  let(:action) { Web::Controllers::Users::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
