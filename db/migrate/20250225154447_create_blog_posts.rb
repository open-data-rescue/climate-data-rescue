class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content

      t.string :author, index: true
      t.string :slug, index: true

      t.integer :lock_version, null: false, default: 0
      t.timestamps
    end
  end
end
