class AddsortOrderTofieldGroup < ActiveRecord::Migration
  def change
    add_column :field_groups, :sort_order, :integer
  end
end
