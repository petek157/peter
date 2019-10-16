class CreateResumesCertificatesJoin < ActiveRecord::Migration[5.2]
  def up
    create_table :resumes_certificates, :id => false do |t|
      t.integer :resume_id
      t.integer :certificate_id
    end
    add_index :resumes_certificates, [:resume_id, :certificate_id]
  end

  def down
    drop_table :resumes_certificates
  end
end
