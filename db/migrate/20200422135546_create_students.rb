class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :password
      t.string :login
      t.string :name
      t.string :group
      t.integer :year

      t.timestamps
    end
  end
end
