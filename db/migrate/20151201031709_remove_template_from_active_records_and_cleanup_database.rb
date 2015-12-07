class RemoveTemplateFromActiveRecordsAndCleanupDatabase < ActiveRecord::Migration
  def change
    
# ******** I had to comment all this in order to get the next migration to work
    
    #drop_table :templates
    
    #add_column :pagetypes, :default_zoom, :float
    #add_column :pagetypes, :description, :string
    #remove_column :pagetypes, :author
    #remove_column :pagetypes, :extern_ref
    #remove_column :pagetypes, :pagetype_id
    
    #remove_column :assets, :template_id
    #remove_column :assets, :pagetype_id
    #add_column :assets, :pagetype_id, :integer
    #add_index :assets, :pagetype_id
    #
    #remove_column :fieldgroups, :template_id
    #add_column :fieldgroups, :pagetype_id, :integer
    #add_index :fieldgroups, :pagetype_id
    
    #remove_column :ledgers, :pagetype_id
    
  end
end
