class CreateTechesResumes < ActiveRecord::Migration[5.2]
  def change
    create_table :teches_resumes do |t|
    end
  end

  def up
    create_table :teches_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :teches_resumes, [:tech_id, :resume_id]
    drop_table :techs_resumes
  end

  def down
    create_table :techs_resumes, :id => false do |t|
      t.integer :tech_id
      t.integer :resume_id
    end
    add_index :techs_resumes, [:tech_id, :resume_id]
    
    drop_table :teches_resumes
  end

end
