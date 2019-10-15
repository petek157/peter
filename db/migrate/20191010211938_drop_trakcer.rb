class DropTrakcer < ActiveRecord::Migration[5.2]
  def change
    drop_table :trackers
  end
end
