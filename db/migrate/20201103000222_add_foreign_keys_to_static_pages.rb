class AddForeignKeysToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :static_pages, :static_pages, column: :parent_id
  end
end
