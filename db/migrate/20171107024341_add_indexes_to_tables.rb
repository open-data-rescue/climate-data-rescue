class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index(:annotations, :transcription_id, name: 'by_transcription')
    add_index(:annotations, :field_group_id, name: 'by_field_group')
    add_index(:annotations, :page_id, name: 'by_page')
    add_index(:annotations, :date_time_id, name: 'by_date_time')

    add_index(:page_days, :page_id, name: 'by_page')
    add_index(:page_days, :user_id, name: 'by_user')
  end
end
