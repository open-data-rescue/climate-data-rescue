class CreateAssetCollections < ActiveRecord::Migration
  def change
    create_table :asset_collections do |t|
      t.string :title
      t.string :author
      t.string :extern_ref

      t.timestamps
    end
  end
end
