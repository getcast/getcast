Hanami::Model.migration do
  change do
    create_table :episodes do
      primary_key :id
      foreign_key :podcast_id, :podcasts, on_delete: :cascade, null: false 
      column :title, String
      column :subtitle, String
      column :description, String
      column :media_url, String
      column :duration, String
    	column :publication_date, Time, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
