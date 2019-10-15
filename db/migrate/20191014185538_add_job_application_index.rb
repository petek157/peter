class AddJobApplicationIndex < ActiveRecord::Migration[5.2]
  def change
    add_column :trackers, :job_application_id, :integer

    add_index :trackers, :job_application_id
  end
end
