class Updater
	def initialize()
		@flickr = Flickr.new('flickr.yml')
	end

	def verify(source, last_updated)
		photos = flickr.photos.search(:text => source, 
			:min_upload_date => last_updated)
		if photos.size > 0
			true
		else
			false
		end
	end

	def update(source)
		photos = flickr.photos.search(:text => search_text, :per_page => 500)
		new_pages = photos.pages

		new_photos = Set.new
		(1..new_pages).to_a.each do |page|
			photos = flickr.photos.search(:text => search_text, 
				:per_page => 500, :page => page)

			photos.each do |photo|
				new_photos << photo.url(:medium)
		  	end
		end

		new_photos
	end
end