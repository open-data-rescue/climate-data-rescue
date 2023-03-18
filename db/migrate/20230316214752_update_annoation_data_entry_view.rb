class UpdateAnnoationDataEntryView < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE DEFINER = 'root'@'localhost' SQL SECURITY INVOKER VIEW annotations_and_data_entries AS
        select
          a.id as annotation_id,
          a.transcription_id, a.page_id, p.page_type_id, p.start_date as page_start_date,
          a.observation_date, a.created_at, a.updated_at, a.field_group_id,
          d.user_id,
          d.id as 'data_entry_id', d.value,
          IF ((d.value REGEXP '^-?[0-9]+\\.?[0-9]*$'), CAST(d.value as DECIMAL(14,4)), null) as value_as_number,
          d.field_options_ids,
          d.field_id,
          field_stuff.internal_name,
          field_stuff.field_key
          from annotations a
          join data_entries d on d.annotation_id = a.id
          join pages p on p.id = a.page_id
          join
          (
          select
            f.id as field_id, f.field_key, f.internal_name, f.period, f.measurement_type, f.measurement_unit_original, f.measurement_unit_si, f.time_of_day,
            ptfg.page_type_id, fgf.field_group_id
            from fields f
            join field_groups_fields fgf on fgf.field_id = f.id
            join page_types_field_groups ptfg on ptfg.field_group_id = fgf.field_group_id
          ) field_stuff on field_stuff.field_id = d.field_id and field_stuff.page_type_id = p.page_type_id
    SQL
    # order by a.transcription_id, a.page_id, a.observation_date asc, a.field_group_id
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS annotations_and_data_entries;
    SQL
  end
end
