Database.config \
	adapter: :postgres, \
	user: 'getcast', \
	password: 'marvelouspandaband', \
	host: 'localhost', \
	database: 'getcast_test' \
do
	create_table?(:podcasts) do
		primary_key :id
		String :title, null: true
		String :desc, null: true
		String :feed_url, null: false
		String :image_url, null: true
		DateTime :last_updated, null: true
		DateTime :date_added, null: false, default: Sequel::CURRENT_TIMESTAMP
	end

	create_table?(:episodes) do
		primary_key :id
		foreign_key :podcast_id, :podcasts, null: false
		String :title, null: true
		String :desc, null: true
		String :media_url, null: true
		DateTime :pub_date, null: true
		DateTime :date_added, null: false, default: Sequel::CURRENT_TIMESTAMP
	end

	create_table?(:users) do
		primary_key :id
		String :username, null: false
		String :email, null: false
		DateTime :last_login, null: true
	end

	create_join_table?({user_id: :users, podcast_id: :podcasts}, name: :subscriptions)
end

Application.config do
	pool do # example 1
		sources PodcastRepository.new    # Sources list
		extractor EpisodeExtractor       # Extractor
		repository EpisodeRepository     # Repository
	end
end