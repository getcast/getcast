require 'spec_helper'

describe PodcastRepository do
  # place your tests here
  before do
   @duck =  PodcastRepository.new.create(title: "Foo_duck_2000", url: "foo_duck_2000.com", description: "Useless bird")
  end

  after do
    PodcastRepository.new.delete(@duck.id)
  end

 it 'search "Foo_duck_2000" in title' do 
  rep = PodcastRepository.new
  search_s = "Foo_duck_2000"

  search_r = rep.search(search_s)
  search_r.each do |podcast|
	podcast.title.downcase.include?(search_s.downcase).must_equal true
  end
 
 end

 it 'search "Foo_duck_2000" in description' do 
  rep = PodcastRepository.new
  search_s = "Foo_duck_2000"

  search_r = rep.search(search_s)
  search_r.each do |podcast|
	podcast.description.downcase.include?(search_s.downcase).must_equal false
  end
 end

 it 'search "Foo_duck_2000" in url' do 
  rep = PodcastRepository.new
  search_s = "Foo_duck_2000"

  search_r = rep.search(search_s)
  search_r.each do |podcast|
	podcast.url.downcase.include?(search_s.downcase).must_equal true
  end
 end

end
