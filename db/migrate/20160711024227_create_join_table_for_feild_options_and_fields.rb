class CreateJoinTableForFeildOptionsAndFields < ActiveRecord::Migration
  def change
    create_join_table :field_options, :fields do |t|
      t.index :field_option_id
      t.index :field_id
    end
  end
end
