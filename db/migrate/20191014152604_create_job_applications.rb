class CreateJobApplications < ActiveRecord::Migration[5.2]
  def up
    create_table :job_applications do |t|
      t.string :company
      t.string :position_applied
      t.string :gen_code
      t.integer :click_count
      t.string :response
      t.text :application_notes
      t.timestamps
    end
  end

  def down
    drop_table :job_applications
  end

end
