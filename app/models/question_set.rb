class QuestionSet < ApplicationRecord
  belongs_to :test
  belongs_to :question


	def self.create_new_set(questions_ids, test_id)
		questions_ids.each do |q_id| 
			q_set = QuestionSet.new(test_id: test_id, question_id: q_id)
			if q_set.save 
				print "\n question #{q_id} was added to question set \n"
			else 
				print "\n question #{q_id} was not added to question set \n"
			end 
		end 
	end 	
end
