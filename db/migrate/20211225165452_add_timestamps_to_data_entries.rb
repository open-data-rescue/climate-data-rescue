class AddTimestampsToDataEntries < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :data_entries, null: false, default: -> { 'NOW()' }
  end
end
