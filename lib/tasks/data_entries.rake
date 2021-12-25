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
end
