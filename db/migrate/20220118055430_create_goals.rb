class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.string :type
      t.integer :note_id

      t.timestamps
    end
  end
end
