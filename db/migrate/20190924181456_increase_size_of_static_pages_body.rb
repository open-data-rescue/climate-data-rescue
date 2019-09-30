class IncreaseSizeOfStaticPagesBody < ActiveRecord::Migration[5.2]
  def up
    change_column :static_page_translations, :body, :text, limit: 4_294_967_295
  end

  def down
  end
end
