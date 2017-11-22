Hanami::Model.migration do
  change do
  	add_column  :episodes, :listens, Integer, default: 0
  	add_column  :podcasts, :listens, Integer, default: 0
  end
end
