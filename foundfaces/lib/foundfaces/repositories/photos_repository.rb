class PhotosRepository < Hanami::Repository

	def search(data)
		photos.where(url:data).limit(1).first
	end

	def batch_update(new_data)
		new_data.each do |data|
			create(url: data[:url], uploaded_at: data[:uploaded_at])
		end	
	end

	def take(limit)
		photos.order{uploaded_at.desc}.limit(limit)
	end	

	def last_updated
		photos.order{uploaded_at.desc}.limit(1).one.uploaded_at
	end
end
