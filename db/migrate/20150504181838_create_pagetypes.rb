class CreatePagetypes < ActiveRecord::Migration
  def change
    create_table :pagetypes do |t|
      t.string :title
      t.string :author
      t.string :extern_ref

      t.timestamps
    end
  end
end
