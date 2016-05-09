class AddDateToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :observation_date, :datetime
  end
end
