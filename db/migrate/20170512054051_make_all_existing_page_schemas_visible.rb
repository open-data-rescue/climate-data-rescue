class MakeAllExistingPageSchemasVisible < ActiveRecord::Migration
  def up
    PageType.update_all(visible: true)
  end

  def down
  end
end
