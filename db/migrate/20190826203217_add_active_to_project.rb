class AddActiveToProject < ActiveRecord::Migration[5.2]
  def up
    add_column :projects, :active, :boolean, :default => false
  end

  def down
    remove_column :projects, :active
  end
end
