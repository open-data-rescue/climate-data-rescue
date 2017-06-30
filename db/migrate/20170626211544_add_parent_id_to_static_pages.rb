class AddParentIdToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :parent_id, :integer
  end
end
