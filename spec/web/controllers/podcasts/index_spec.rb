require 'spec_helper'
require_relative '../../../../apps/web/controllers/podcasts/index'

describe Web::Controllers::Podcasts::Index do
  let(:action) { Web::Controllers::Podcasts::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
