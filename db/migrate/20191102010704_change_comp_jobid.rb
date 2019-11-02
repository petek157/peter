class ChangeCompJobid < ActiveRecord::Migration[5.2]
  def up
    remove_column(:job_applications, :compid)
    add_column(:job_applications, :comp_jobid, :string)
  end

  def down 
    remove_column(:job_applications, :comp_jobid)
    add_column(:job_applications, :compid, :string)
  end
end
