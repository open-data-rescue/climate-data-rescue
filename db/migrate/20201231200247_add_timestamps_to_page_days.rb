class AddTimestampsToPageDays < ActiveRecord::Migration[5.2]
  def change
    change_table :page_days do |t|
      t.integer :lock_version, null: false, default: 0
      t.timestamps null: false, default: -> { DateTime.now }
    end
  end
end
