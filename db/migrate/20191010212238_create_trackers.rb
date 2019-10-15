class CreateTrackers < ActiveRecord::Migration[5.2]
  def up
    create_table :trackers do |t|
      t.string :ip_address
      t.integer :application_id
      t.timestamps
    end

    add_index :trackers, :application_id
  end

  def down
    drop_table :trackers
  end
end
