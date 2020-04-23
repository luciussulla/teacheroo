class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.integer :control_level

      t.timestamps
    end
  end
end
