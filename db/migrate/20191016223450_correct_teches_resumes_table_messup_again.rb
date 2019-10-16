class CorrectTechesResumesTableMessupAgain < ActiveRecord::Migration[5.2]
  def up
    drop_table :teches_resumes

    create_table :resumes_teches, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :resumes_teches, [:tech_id, :resume_id]
  end

  def down
    drop_table :resumes_teches

    create_table :teches_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :teches_resumes, [:tech_id, :resume_id]
  end
end
