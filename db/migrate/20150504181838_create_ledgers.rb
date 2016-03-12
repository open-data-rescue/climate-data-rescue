class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.string :title
      t.string :type
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
