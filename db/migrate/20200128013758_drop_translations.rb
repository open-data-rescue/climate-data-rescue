class DropTranslations < ActiveRecord::Migration[5.2]
  def up
    drop_table :translations
  end

  def down; end
end
