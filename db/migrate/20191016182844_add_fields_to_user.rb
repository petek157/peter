class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :phone, :string
    add_column :users, :website, :string
    add_column :users, :linkedIn, :string
    add_column :users, :github, :string
    add_column :users, :education, :string
  end

  def down
    remove_column :users, :phone
    remove_column :users, :website
    remove_column :users, :linkedIn
    remove_column :users, :github
    remove_column :users, :education
  end
end
