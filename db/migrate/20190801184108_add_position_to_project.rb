class AddPositionToProject < ActiveRecord::Migration[5.2]
  def up
    add_column(:projects, :position, :integer)
  end

  def down 
    remove_column(:projects, :position)
  end
end
