class AddShowInTranscriberToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :show_in_transcriber, :boolean, nil: false, default: false
  end
end
