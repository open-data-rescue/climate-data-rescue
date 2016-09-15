class MoveVolumeToPageFromLedger < ActiveRecord::Migration
  def change
    remove_column :ledgers, :volume
    add_column :pages, :volume, :string
  end
end
