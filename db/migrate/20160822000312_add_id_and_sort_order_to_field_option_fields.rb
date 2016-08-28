class AddIdAndSortOrderToFieldOptionFields < ActiveRecord::Migration
  def change
    add_column :field_options_fields, :id, :primary_key
    add_column :field_options_fields, :sort_order, :integer
  end
end
