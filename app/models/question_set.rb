class QuestionSet < ApplicationRecord
  belongs_to :test
  belongs_to :question


	def self.create_new_set(questions_ids, test_id)
		print "\n"
		print "questions_ids are #{questions_ids} \n"
		print "test_id is #{test_id}\n"
		print "\n"

		questions_ids.each do |q_id| 
			q_set = QuestionSet.new(test_id: test_id, question_id: q_id)
			if q_set.save 
			
				print "\n question #{q_id} was added to question set. Test id is #{test_id}\n"
			else 
				print "\n question #{q_id} was not added to question set. Test id is #{test_id} \n"
			end 
		end 
	end 	
end