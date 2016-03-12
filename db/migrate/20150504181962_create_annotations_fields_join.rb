class CreateAnnotationsFieldsJoin < ActiveRecord::Migration
  def change
    create_join_table :annotations, :fields, table_name: :annotations_data do |t|
      t.index :annotation_id
      t.index :field_id

      t.string :value

      t.timestamps
    end
  end
end
