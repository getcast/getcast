require 'flickr_fu'

class Updater
	def initialize()
		path = File.dirname(__FILE__)
		@flickr = Flickr.new(path + '/flickr.yml')
	end

	def verify(source, last_updated)
		photos = @flickr.photos.search(:text => source, 
			:min_upload_date => last_updated)
		if photos.size > 0
			true
		else
			false
		end
	end

	def update(source, last_updated)
		photos = @flickr.photos.search(:text => source, 
			:per_page => 500, :min_upload_date => last_updated)
		new_pages = photos.pages

		new_photos = Set.new
		(6..new_pages).to_a.each do |page|
			photos = @flickr.photos.search(:text => source, 
				:per_page => 500, :page => page, :min_upload_date => last_updated)

			photos.each do |photo|
				n = {}
				n[:url] = photo.url(:medium)
				n[:uploaded_at] = photo.uploaded_at
				new_photos << n
		  	end
		end

		new_photos
	end
end
