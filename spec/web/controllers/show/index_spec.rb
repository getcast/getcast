require 'spec_helper'
require_relative '../../../../apps/web/controllers/show/index'

describe Web::Controllers::Show::Index do
  let(:action) { Web::Controllers::Show::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
