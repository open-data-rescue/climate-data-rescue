class AddShowHeaderToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :title_as_header, :boolean, default: true, nil:false
  end
end
