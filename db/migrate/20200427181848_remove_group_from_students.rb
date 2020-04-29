class RemoveGroupFromStudents < ActiveRecord::Migration[6.0]
  def change
  	remove_column :students, :group
  end
end
