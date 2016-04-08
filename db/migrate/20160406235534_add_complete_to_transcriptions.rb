class AddCompleteToTranscriptions < ActiveRecord::Migration
  def change
    add_column :transcriptions, :complete, :boolean, {null: false, default: false}
  end
end
