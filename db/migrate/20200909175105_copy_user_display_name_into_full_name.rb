class CopyUserDisplayNameIntoFullName < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        User.all.each do |user|
          user.full_name = user.display_name
          user.save
        end
      end
    end
  end
end
