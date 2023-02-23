class CreatePageInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :page_infos do |t|
      t.string :observer
      t.string :lat
      t.string :lon
      t.string :location
      t.references :page
      t.references :user

      t.timestamps
    end
  end
end
