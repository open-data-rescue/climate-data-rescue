class RemoveTemplateFromActiveRecordsPartTwo < ActiveRecord::Migration
  def change
    remove_column :assets, :template_id
    remove_column :assets, :pagetype_id
    add_column :assets, :pagetype_id, :integer
    add_index :assets, :pagetype_id
    
    remove_column :fieldgroups, :template_id
    add_column :fieldgroups, :pagetype_id, :integer
    add_index :fieldgroups, :pagetype_id
    
    remove_column :ledgers, :pagetype_id
  end
end
