require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/subs_ajax'

describe Web::Controllers::Users::SubsAjax do
  let(:action) { Web::Controllers::Users::SubsAjax.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
