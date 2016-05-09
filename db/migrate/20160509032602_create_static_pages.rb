class CreateStaticPages < ActiveRecord::Migration
  def up
    create_table :static_pages do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.boolean :show_in_header, default: false, null: false
      t.boolean :show_in_sidebar, default: false, null: false
      t.boolean :visible, default: true, null: false
      t.string  :foreign_link
      t.integer :position, default: 1, null: false

      t.string :meta_keywords
      t.string :meta_title
      t.string :meta_description

      t.timestamps null: false
    end

    add_index(:static_pages, :slug)
  end

  def down
  	drop_table :static_pages
  end
end
