class AddTextSymbolToFieldOptions < ActiveRecord::Migration
  def change
    add_column :field_options, :text_symbol, :string
  end
end
