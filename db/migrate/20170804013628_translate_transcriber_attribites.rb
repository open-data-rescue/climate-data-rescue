class TranslateTranscriberAttribites < ActiveRecord::Migration
  def self.up
      I18n.with_locale(:en) do
        # Field
        Field.create_translation_table!({
          :name => :string,
          :full_name => :string,
          :help => :text,
        }, {
          :migrate_data => true,
          :remove_source_columns => true
        })
        # FieldGroup
        FieldGroup.create_translation_table!({
          :name => :string,
          :display_name => :string,
          :help => :text,
        }, {
          :migrate_data => true,
          :remove_source_columns => true
        })
        # FieldOption
        FieldOption.create_translation_table!({
          :name => :string,
          :help => :text,
        }, {
          :migrate_data => true,
          :remove_source_columns => true
        })
      end
    end

    def self.down
      Field.drop_translation_table! :migrate_data => true
      FieldGroup.drop_translation_table! :migrate_data => true
      FieldOption.drop_translation_table! :migrate_data => true
    end
end
