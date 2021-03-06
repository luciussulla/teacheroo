class Group < ApplicationRecord
	has_many :students
	#validates_uniqueness_of :student_id
	has_many :group_tests
	has_many :tests, through: :group_tests

	#belongs_to :teacher
	
	# FOR NOW THE 	belongs_to :teacher is not added so groups can 
	# be created independently of belonging or not belonging to a teacher

	def self.add_students_to_group(group, students_ids)
		if students_ids.present?
			print "\n inside the add_students_to_group function \n"
			print "\n group id is #{group.id} student_ids are: #{students_ids} \n"
			group_id = group.id
			students_ids.each do |student_id| 
				student = Student.find(student_id.to_i)
				student.group_id = group_id.to_i
				student.save
				print "\n Student was created \n"
			end
		end 	
	end 

	def has_test?(test)
		status = GroupTest.where(group_id: self.id, test_id: test.id)
		if !status.blank? || !status == nil 
			return true 
		else 
			return false 
		end 		
	end 
end
