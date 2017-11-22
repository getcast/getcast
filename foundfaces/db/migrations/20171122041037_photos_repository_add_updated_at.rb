Hanami::Model.migration do
  change do
	add_column :photos, :uploaded_at, DateTime
  end
end
