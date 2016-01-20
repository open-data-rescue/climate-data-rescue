class CreateCollectionGroups < ActiveRecord::Migration
  def change
    create_table :collection_groups do |t|
      t.string :title
      t.string :author
      t.string :extern_ref
      t.integer :asset_collection_id
      t.timestamps
    end
    add_index "collection_groups", ["asset_collection_id"], :name => "index_collection_groups_on_asset_collection_id"
  end
end
