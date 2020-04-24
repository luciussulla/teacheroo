class AddGroupIdToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :group_id, :integer
  end
end
