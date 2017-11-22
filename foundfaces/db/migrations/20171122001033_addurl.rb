Hanami::Model.migration do
  change do
	add_column :photos, :url, String, null: false
  end
end
