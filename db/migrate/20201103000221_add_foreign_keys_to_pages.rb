class AddForeignKeysToPages < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :pages, :page_types
  end
end
