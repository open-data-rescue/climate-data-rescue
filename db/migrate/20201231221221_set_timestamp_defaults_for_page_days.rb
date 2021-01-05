class SetTimestampDefaultsForPageDays < ActiveRecord::Migration[5.2]
  def up
    PageDay.update_all(created_at: DateTime.now, updated_at: DateTime.now)
  end

  def down; end
end
