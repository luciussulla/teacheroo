class AddTeacherIdToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :teacher_id, :integer
  end
end
