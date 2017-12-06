require 'spec_helper'

describe Web.routes do
  before do
   @desc = Web.routes
  end

  it 'recognizes "GET /podcasts"' do
    env   = Rack::MockRequest.env_for('/podcasts')
    route = @desc.recognize(env)

    route.routable?.must_equal true

    route.path.must_equal '/podcasts'
    route.verb.must_equal  'GET'
    route.params.must_equal nil.to_h
  end

 it 'recognizes "/podcasts/16287"' do
  env = Rack::MockRequest.env_for('/podcasts/16287')
  route = @desc.recognize(env)
  expected_hash = {:id => "16287"}
  route.routable?.must_equal true

  route.path.must_equal '/podcasts/16287'
  route.verb.must_equal  'GET'
  route.params.must_equal expected_hash
 end
end
