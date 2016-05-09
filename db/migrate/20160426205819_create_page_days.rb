class CreatePageDays < ActiveRecord::Migration
  def change
    create_table :page_days do |t|
      t.date :date
      t.integer :num_observations
      t.references :page
      t.references :user
    end
  end
end
