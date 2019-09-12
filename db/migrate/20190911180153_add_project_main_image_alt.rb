class AddProjectMainImageAlt < ActiveRecord::Migration[5.2]
  def up
    add_column :projects, :main_alt, :string
  end

  def down
    remove_column :projects, :main_alt
  end
end
