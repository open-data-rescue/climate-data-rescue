class AddLedgerIdToPagetype < ActiveRecord::Migration
  def change
  	add_column :pagetypes, :ledger_id, :integer
  	add_index :pagetypes, :ledger_id
  end
end
