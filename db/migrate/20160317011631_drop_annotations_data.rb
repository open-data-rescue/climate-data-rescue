class DropAnnotationsData < ActiveRecord::Migration
  def up
    #drop_table :annotations_data
    
    #TODO: fix this fucked up migration situation
    drop_table :annotations_data
  end
  def down

  end
end
