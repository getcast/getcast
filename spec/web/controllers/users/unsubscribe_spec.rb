require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/unsubscribe'

describe Web::Controllers::Users::Unsubscribe do
  let(:action) { Web::Controllers::Users::Unsubscribe.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
