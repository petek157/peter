class CreateProjectsResumesJoin < ActiveRecord::Migration[5.2]
  def up
    create_table :projects_resumes, :id => false do |t|
      t.integer :project_id
      t.integer :resume_id
    end
    add_index :projects_resumes, [:project_id, :resume_id]
  end

  def down
    drop_table :projects_resumes
  end
end
