class CreateClassSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :class_sessions do |t|
      t.references :course, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true
      t.integer :teacher_id

      t.timestamps
    end
    add_index :class_sessions, :teacher_id
  end
end
