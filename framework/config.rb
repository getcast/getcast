Application.config do
	pool do # example 1
		sources "mysource1", "mysource2" # Sources list
		extractor ExtractorClassA        # Extractor
		repository RepositoryClassB      # Repository
	end

	pool do # you can add more poolers
		sources "another"
		extractor ExtractorClassC
		repository RepositoryClassD              
	end
end