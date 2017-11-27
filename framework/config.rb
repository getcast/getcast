Application.config do
	sources
		"face"

	extractor
		FlickrExtractor

	repository
		PhotoRepository
end