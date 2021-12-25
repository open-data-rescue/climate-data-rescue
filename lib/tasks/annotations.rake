namespace :annotations do
  desc "Clears annotations that don't have geometry"
  task :clean_geometryless => :environment do
    require 'annotation'

    Annotation.without_dimensions.includes(:data_entries).find_in_batches do |annotations|
      annotations.each do |annotation|
        annotation.data_entries.delete_all
        annotation.delete
      end
    end
  end
end
