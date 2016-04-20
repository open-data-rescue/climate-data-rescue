class AddDateTimeIdToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :date_time_id, :string
  end
end
