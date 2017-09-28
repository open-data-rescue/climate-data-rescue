class RenameColumnShowInSidebarForStaticPages < ActiveRecord::Migration
  def change
    rename_column :static_pages, :show_in_sidebar, :show_in_footer
  end
end
