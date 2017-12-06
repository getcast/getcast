Database.config \
	adapter: :postgres, \
	user: 'getcast', \
	password: 'marvelouspandaband', \
	host: 'localhost', \
	database: 'getcast_test' \
do
	create_table?(:episodes) do
		primary_key :id
		String :title, null: true
		String :desc, null: true
		String :url, null: true
		DateTime :pubdate, null: true
		DateTime :date_added, null: false, default: Sequel::CURRENT_TIMESTAMP
	end

	create_table?(:podcasts) do
		primary_key :id
		String :title, null: true
		String :desc, null: true
		String :url, null: true
		DateTime :date_added, null: false, default: Sequel::CURRENT_TIMESTAMP
	end
end

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
		subscribers SubscriberClassE   # optional
		wait_time 500                  # optional, default: 300. (in seconds)     
	end
end