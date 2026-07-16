class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :class_session, null: false, foreign_key: true
      t.integer :student_id
      t.string :grade

      t.timestamps
    end
    add_index :enrollments, :student_id
  end
end
