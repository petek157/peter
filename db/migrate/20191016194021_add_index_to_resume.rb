class AddIndexToResume < ActiveRecord::Migration[5.2]
  def change
    add_column :resumes, :job_application_id, :integer

    add_index :resumes, :job_application_id
  end
end
