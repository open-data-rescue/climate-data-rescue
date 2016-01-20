class RenameDataModels < ActiveRecord::Migration
  def up
    rename_table :collection_groups, :ledgers
    rename_table :asset_collections, :pagetypes
    rename_table :entities, :fieldgroups
    rename_column :ledgers, :asset_collection_id, :pagetype_id
    rename_column :pagetypes, :asset_collection_id, :pagetype_id
    rename_column :pagetypes, :collection_group_id, :ledger_id
    rename_column :assets, :asset_collection_id, :pagetype_id
    rename_column :fields, :entity_id, :fieldgroup_id
    rename_column :annotations, :entity_id, :fieldgroup_id
  end

  def down
    rename_column :ledgers, :pagetype_id, :asset_collection_id
    rename_column :pagetypes, :pagetype_id, :asset_collection_id
    rename_column :pagetypes, :ledger_id, :collection_group_id
    rename_column :assets, :pagetype_id, :asset_collection_id
    rename_column :fields, :fieldgroup_id, :entity_id
    rename_column :annotations, :fieldgroup_id, :entity_id
    rename_table :ledgers, :collection_groups
    rename_table :pagetypes, :asset_collections
    rename_table :fieldgroups, :entities
  end
end