class RemoveOldRedundantAttributesFromDataModel < ActiveRecord::Migration
  def up
    remove_column :field_groups, :page_type_id
    remove_column :field_groups, :position

    remove_column :fields, :field_group_id
    remove_column :fields, :position
    remove_column :fields, :initial_value
    remove_column :fields, :options
    remove_column :fields, :validations

    remove_column :ledgers, :start_date
    remove_column :ledgers, :end_date

    remove_column :pages, :order
    remove_column :pages, :classification_count
    remove_column :pages, :transcriber_id

    remove_column :users, :num_contributions
  end

  def down
  end
end
