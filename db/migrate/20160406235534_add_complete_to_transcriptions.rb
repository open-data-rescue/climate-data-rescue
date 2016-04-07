class AddCompleteToTranscriptions < ActiveRecord::Migration
  def change
    add_column :transcriptions, :complete, :boolean
  end
end
