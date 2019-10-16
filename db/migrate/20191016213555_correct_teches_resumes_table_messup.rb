class CorrectTechesResumesTableMessup < ActiveRecord::Migration[5.2]
  def up
    drop_table :techs_resumes
    drop_table :teches_resumes

    create_table :teches_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :teches_resumes, [:tech_id, :resume_id]

  end

  def down
    drop_table :teches_resumes

    create_table :teches_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :teches_resumes, [:tech_id, :resume_id]


    create_table :techs_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :techs_resumes, [:tech_id, :resume_id]
    
  end
end
