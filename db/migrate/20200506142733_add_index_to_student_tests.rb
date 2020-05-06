class AddIndexToStudentTests < ActiveRecord::Migration[6.0]
  add_index :student_tests, [:test_id, :student_id], unique: true, name: 'my_custom_index'
end
