class SubsRepository < Hanami::Repository
	def find_subs(userid, podcastid)
		subs
		    .where(user_id: userid, podcast_id: podcastid)
		    .limit(1)
		    .first	
	end 
	
	def find_podcasts(userid,podcastid)
		subs
			.join(:podcasts)
			.where(user_id: userid, podcast_id: podcastid)
	end
end
