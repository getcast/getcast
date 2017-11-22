class PhotosRepository < Hanami::Repository

	def search(data)
		photos.where(url:data).limit(1).first
	end

	def batch_update(new_data)
		new_data.each do |data|
			photos.create(url: data)
		end	
	end

	def all(limit)
		photos.limit(limit)
	end	

end
