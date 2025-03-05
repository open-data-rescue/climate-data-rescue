class AddJobTitle < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :published_at, :datetime, default: nil
    add_column :blog_posts, :job_title, :string, limit: 150
    add_column :blog_posts, :published, :boolean, default: false
  end
end
