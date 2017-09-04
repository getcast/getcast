Hanami::Model.migration do
  change do
    create_table :podcasts do
      primary_key :id
      column :url,         String
      column :title,       String
      column :description, String
      column :created_at,  DateTime, null: false
      column :updated_at,  DateTime, null: false
    end
  end
end
