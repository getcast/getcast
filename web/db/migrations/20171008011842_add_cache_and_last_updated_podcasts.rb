Hanami::Model.migration do
  change do
  	add_column	:podcasts, :cache, String, null: true
  	add_column	:podcasts, :last_updated, DateTime,	null: true
  end
end
