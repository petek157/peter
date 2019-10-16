class CorrectCertificatesResumesTableMessup < ActiveRecord::Migration[5.2]
  def up
    drop_table :resumes_certificates

    create_table :certificates_resumes, :id => false do |t|
      t.integer :resume_id
      t.integer :certificate_id
    end
    add_index :certificates_resumes, [:resume_id, :certificate_id]
  end

  def down
    drop_table :certificates_resumes

    create_table :resumes_certificates, :id => false do |t|
      t.integer :resume_id
      t.integer :certificate_id
    end
    add_index :resumes_certificates, [:resume_id, :certificate_id]
  end
end
