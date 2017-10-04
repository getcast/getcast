require 'spec_helper'
require_relative '../../../../apps/web/controllers/podcasts/show'

describe Web::Controllers::Podcasts::Show do
  let(:action) { Web::Controllers::Podcasts::Show.new }
  let(:params) { Hash[] }

  before(:all) do
    @repository = PodcastRepository.new
    @podcast = @repository.create(title: "Cool Podcast", url: "https://coolpodcast.com/", description: "The coolest podcast ever1")
  end

  it 'is successful' do
    response = action.call(params.merge(id: @podcast.id))
    response[0].must_equal 200
  end

  after(:all) do
    @repository.delete(@podcast.id)
  end
end
