class ChangeResStringsToText < ActiveRecord::Migration[5.2]
  def up
    change_column(:resumes, :title, :text)
    change_column(:resumes, :edu_desc, :text)
    change_column(:resumes, :cert_desc, :text)
    change_column(:resumes, :tech_desc, :text)
    change_column(:resumes, :expir_desc, :text)
  end

  def down
    change_column(:resumes, :title, :string)
    change_column(:resumes, :edu_desc, :string)
    change_column(:resumes, :cert_desc, :string)
    change_column(:resumes, :tech_desc, :string)
    change_column(:resumes, :expir_desc, :string)
  end
end
