class AddFilenameAttributesToPageTable < ActiveRecord::Migration
  def change
    add_column :pages, :accession_number, :string
    add_column :pages, :ledger_id, :string
    add_index :pages, :ledger_id
    add_column :pages, :ledger_volume, :string
    add_column :pages, :from_date, :date
    add_column :pages, :to_date, :date
  end
end
