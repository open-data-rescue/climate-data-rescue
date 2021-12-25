namespace :data_entries do
  desc "Sets correct timestamps from data entry annotation"
  task :correct_timestamps => :environment do
    require 'annotation'

    Annotation.includes(:data_entries).find_in_batches do |annotations|
      annotations.each do |annotation|
        annotation.data_entries.update_all(
          created_at: annotation.created_at,
          updated_at: annotation.updated_at
        )
      end
    end
  end

  desc "Deletes data entries with null values"
  task :clear_nulls => :environment do
    require 'data_entry'

    DataEntry.where(value: nil).delete_all
  end
end
