class AddCompJobid < ActiveRecord::Migration[5.2]
  def up
    add_column(:job_applications, :compid, :string)
  end

  def down 
    remove_column(:job_applications, :compid)
  end
end
