class StudentGroup < ApplicationRecord
  belongs_to :student
  belongs_to :group

  def self.add_students_to_group(group, students_ids)
  	group_id = group.id
  	students_ids.each do |s_id| 
  		s_group = StudentGroup.create(group_id: group_id, student_id: s_id)
  		if s_id.save 
  			print "\n StudentGroup was created group is #{group_id} the student id is #{s_id} \n"
  		else 
  			print "\n StudentGroup was NOT created group is #{group_id} the student id is #{s_id} \n"
  		end 	
  	end
  end 

end
