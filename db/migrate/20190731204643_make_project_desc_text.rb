class MakeProjectDescText < ActiveRecord::Migration[5.2]
  def up
    change_column(:projects, :description, :text)
  end

  def down
    change_column(:projects, :description, :string)
  end
end
