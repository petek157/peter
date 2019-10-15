class AddAppidUrl < ActiveRecord::Migration[5.2]
  def up
    add_column :trackers, :url_clicked, :boolean, :default => false
  end

  def down
    remove_column :trackers, :url_clicked
  end
end
