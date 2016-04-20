class AddTranscriberIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :transcriber_id, :integer
  end
end
