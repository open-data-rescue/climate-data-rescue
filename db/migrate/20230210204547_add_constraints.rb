class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    # Add constraints that should be in place

    add_index :ledgers, :ledger_type, unique: true #, name: 'unque_ledger_type'

    add_index :page_types, [:title, :ledger_type, :number], unique: true #, name: 'unque_page_type_title'

    add_index :pages, [:title, :page_type_id, :accession_number, :volume], unique: true, name: 'unque_page_ldgr_vol'
    add_index :pages, :image_file_name, unique: true #, name: 'unque_page_image_file'
  end
end
