class TranslateStaticPages < ActiveRecord::Migration
  def self.up
      I18n.with_locale(:en) do
        StaticPage.create_translation_table!({
          :title => :string, 
          :body => :text, 
          :slug => :string, 
          :meta_keywords => :string, 
          :meta_title => :string,
          :meta_description => :string
        }, {
          :migrate_data => true,
          :remove_source_columns => true
        })
      end
    end

    def self.down
      StaticPage.drop_translation_table! :migrate_data => true
    end
end
