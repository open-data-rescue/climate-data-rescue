class DataEntryAuditView < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE DEFINER = 'root'@'localhost' SQL SECURITY INVOKER VIEW date_entries_audit_details AS
        select
          adev.id as id,
        	u.id as user_id,
        	u.display_name as user_name,
        	p.id as page_id,
        	p.title as page_title,
          pi.location,
        	t.id as transcription_id,
        	a.id as annotation_id,
        	a.observation_date,
        	de.field_id,
        	f.field_key,
        	adev.value,
        	adev.prev_value,
        	adev.notes,
        	adev.whodunnit,
        	adev.created_at as change_time,
        	adev.event,
        	who.id who_id,
        	who.display_name who_name
        from
        	pages p
        left join page_infos pi on
	        pi.page_id = p.id
        join transcriptions t on
        	t.page_id = p.id
        join annotations a on
        	a.transcription_id = t.id
        join data_entries de on
        	de.annotation_id = a.id
        join fields f on
        	de.field_id = f.id
        join users u on
        	de.user_id = u.id
        join audit_data_entry_versions adev on
        	adev.item_id = de.id
        join users who on
        	who.id = adev.whodunnit_as_id
    SQL
  end
  def down
    execute <<-SQL
      DROP VIEW IF EXISTS date_entries_audit_details;
    SQL
  end
end
