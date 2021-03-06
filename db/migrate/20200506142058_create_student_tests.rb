class CreateStudentTests < ActiveRecord::Migration[6.0]

  	def change
	    create_table :student_tests do |t|
	      t.references :test, null: false, foreign_key: true
	      t.references :student, null: false, foreign_key: true
	      t.integer :grade
	      t.integer :time_taken
	      t.datetime :taken_at
	      t.string :remarks

	      t.timestamps
	    end
	end 

end
