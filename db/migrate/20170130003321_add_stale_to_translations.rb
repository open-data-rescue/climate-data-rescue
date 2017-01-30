class AddStaleToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :stale, :boolean, default: false, nil: false
  end
end
