class PostTranslations < ActiveRecord::Migration[7.0]
  def self.up
    I18n.with_locale(:en) do
      Blog::Post.create_translation_table!({
        :title => :string, 
        :content => :text
      }, {
        :migrate_data => true,
        :remove_source_columns => true
      })
    end
  end

  def self.down
    I18n.with_locale(:en) do
      # add_column :blog_posts, :title, :string
      # add_column :blog_posts, :content, :text
      # add_column :blog_posts, :slug, :string, index: true

      Blog::Post.drop_translation_table! migrate_data: true
    end
  end
end
