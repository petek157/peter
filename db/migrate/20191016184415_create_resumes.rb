class CreateResumes < ActiveRecord::Migration[5.2]
  def up
    create_table :resumes do |t|
      t.string :title
      t.string :edu_desc
      t.string :cert_desc
      t.string :tech_desc
      t.string :expir_desc
      t.timestamps
    end
  end

  def down
    drop_table :resumes
  end
end
