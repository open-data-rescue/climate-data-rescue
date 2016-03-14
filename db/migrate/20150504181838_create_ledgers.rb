class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.string :title
      t.string :ledger_type
      t.string :volume
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
