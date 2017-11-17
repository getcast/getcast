Hanami::Model.migration do
  change do
    create_table :subs do
	foreign_key :user_id, :users, on_delete: :cascade, null: false
	foreign_key :podcast_id, :podcasts, on_delete: :cascade, null: false
	primary_key [:user_id, :podcast_id], name: :subscriber	
      	column :created_at, DateTime, null: false
      	column :updated_at, DateTime, null: false
    end
  end
end
