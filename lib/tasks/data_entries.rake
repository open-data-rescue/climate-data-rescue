namespace :data_entries do

  desc ""
  task :find_issues => :environment do  |t, args|
    c = incorrect_entries.count + missing_entries.count

    puts "**** There are #{c} data entries with value issues"
  end

  task :fix_incorrect => :environment do  |t, args|
    PaperTrail.enabled = false

    candidates = incorrect_entries
    candidates.each do |candidate|
      entry = candidate.data_entry

      if candidate.field_options_ids
        ids = candidate.field_options_ids.split(',')
        options = FieldOption.where(id: ids)
        entry.value = options.map{|option| option.value}.join(" ") if options.any?
      else
        options = FieldOption.where(id: candidate.value_as_number)
        entry.value = options.map{|option| option.value}.join(" ") if options.any?
      end

      entry.save!

      putc '.'
    end

    PaperTrail.enabled = true
  end

  task :fix_missing => :environment do  |t, args|
    PaperTrail.enabled = false

    candidates = missing_entries

    candidates.each do |candidate|
      entry = candidate.data_entry

      ids = candidate.field_options_ids.split(',')
      options = FieldOption.where(id: ids)
      entry.value = options.map{|option| option.value}.join(" ") if options.any?

      entry.save!

      putc '.'
    end

    PaperTrail.enabled = true
  end

  def incorrect_entries
    Views::AnnotationsAndDataEntry
      .joins(
        :field,
        :field_options
      )
      .includes(
        :data_entry
      )
      .where(
        "annotations_and_data_entries.value is not null and annotations_and_data_entries.value_as_number = field_options.id"
      )
  end

  def missing_entries
    Views::AnnotationsAndDataEntry
      .includes(
        :data_entry
      )
      .where(
        "(value is null or value = '') and field_options_ids is not null"
      )
  end
end
