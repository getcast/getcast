require 'spec_helper'
require_relative '../../../../apps/web/controllers/podcasts/show'

describe Web::Controllers::Podcasts::Show do
  let(:action) { Web::Controllers::Podcasts::Show.new }
  let(:params) { Hash[id: 16287] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
