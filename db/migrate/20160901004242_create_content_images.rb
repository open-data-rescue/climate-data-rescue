class CreateContentImages < ActiveRecord::Migration
  def change
    create_table :content_images do |t|
      t.attachment :image
      t.string :name

      t.timestamps null: false
    end
  end
end
