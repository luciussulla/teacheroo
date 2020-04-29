class CreateGroupTests < ActiveRecord::Migration[6.0]
  def change
    create_table :group_tests do |t|
      t.references :test, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
