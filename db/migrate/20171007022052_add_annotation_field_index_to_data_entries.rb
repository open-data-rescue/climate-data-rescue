class AddAnnotationFieldIndexToDataEntries < ActiveRecord::Migration
  def change
    add_index :data_entries, [:annotation_id, :field_id], unique: true, name: 'annotation_field'
  end
end
