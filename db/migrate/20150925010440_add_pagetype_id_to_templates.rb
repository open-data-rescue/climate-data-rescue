class AddPagetypeIdToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :pagetype_id, :integer
  end
end
