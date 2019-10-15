class AddCookieToTracker < ActiveRecord::Migration[5.2]
  def up
    add_column(:trackers, :cookie, :string)
  end

  def down 
    remove_column(:trackers, :intro)
  end
end
