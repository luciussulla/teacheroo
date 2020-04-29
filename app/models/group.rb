class Group < ApplicationRecord
	has_many :students
	# FOR NOW THE 	belongs_to :teacher is not added so groups can 
	# be created independently of belonging or not belonging to a teacher

	def self.add_students_to_group(group, students_ids)
		print "\n inside the add_students_to_group function \n"
		print "\n group id is #{group.id} student_ids are: #{students_ids} \n"
		group_id = group.id
		students_ids.each do |student_id| 
			student = Student.find(student_id.to_i)
			student.group_id = group_id.to_i
		end 
	end 
end
