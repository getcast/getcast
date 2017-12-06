class PodcastSubscriber < Subscriber
	def initialize
		@subscriptions = Database[:subscriptions]
	end

	def notify(podcast, new_episodes)
		podcast_users = @subscriptions.join(:users) do |ts, tu|
			(Sequel.qualify(ts, :user_id) == Sequel.qualify(tu, :id)) \
			& (Sequel.qualify(ts, :podcast_id) == podcast.id)
		end
		.select(
			Sequel.qualify(:users, :username),
			Sequel.qualify(:users, :email),
			Sequel.qualify(:users, :last_login)
			)
		podcast_users.each do |user|
			puts user
		end
	end
end