class SubscriptionRepository < Hanami::Repository
	self.relation = :subscriptions

	mapping do
		attribute :user_id, from: :user_id
		attribute :podcast_id, from: :podcast_id
	end
end