class CreateFieldGroups < ActiveRecord::Migration
  def change
    create_table :field_groups do |t|
      t.string :name
      t.string :description
      t.string :help

      t.timestamps
    end
  end
end
