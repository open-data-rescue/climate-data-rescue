class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :description
      t.string :project
      t.float :default_zoom

      t.timestamps
    end
  end
end
