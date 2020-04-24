class CreateStudentGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :student_groups do |t|
      t.references :student, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
