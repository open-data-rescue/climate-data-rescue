class RenameDataModels < ActiveRecord::Migration
  def up
    rename_table :ledgers, :ledgers
    rename_table :pagetypes, :pagetypes
    #rename_table :assets, :pages
    rename_table :fieldgroups, :fieldgroups
    rename_column :ledgers, :pagetype_id, :pagetype_id
    rename_column :pagetypes, :pagetype_id, :pagetype_id
    rename_column :pagetypes, :ledger_id, :ledger_id
    rename_column :assets, :pagetype_id, :pagetype_id
    #rename_column :transcriptions, :asset_id, :page_id
    rename_column :fields, :fieldgroup_id, :fieldgroup_id
    #rename_column :annotations, :asset_id, :page_id
    rename_column :annotations, :fieldgroup_id, :fieldgroup_id
  end

  def down
    rename_column :ledgers, :pagetype_id, :pagetype_id
    rename_column :pagetypes, :pagetype_id, :pagetype_id
    rename_column :pagetypes, :ledger_id, :ledger_id
    rename_column :assets, :pagetype_id, :pagetype_id
    #rename_column :transcriptions, :page_id,:asset_id
    rename_column :fields, :fieldgroup_id, :fieldgroup_id
    #rename_column :annotations, :page_id, :asset_id
    rename_column :annotations, :fieldgroup_id, :fieldgroup_id
    rename_table :ledgers, :ledgers
    rename_table :pagetypes, :pagetypes
    #rename_table :pages, :assets
    rename_table :fieldgroups, :fieldgroups
  end
end