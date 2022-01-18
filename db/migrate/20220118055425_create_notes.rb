class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.text :description
      t.integer :patient_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
