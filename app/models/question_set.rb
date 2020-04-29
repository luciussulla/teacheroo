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

	def self.destroy_those_q_sets(q_set_array)
		q_set_array.each do |q_s| 
			print "Destroying question set with id of #{q_s.id}"
			if QuestionSet.destroy(q_s.id)
				print "destruction completed"
			else 
				print "destruction NOT completed"
			end 
		end 
	end 
=begin
	def self.sql_finder()
		query = <<-SQL 
 			 SELECT * 
		     FROM question_sets
		     WHERE question_sets.question_id = 3
		SQL
		result = ActiveRecord::Base.connection.execute(query)
	end 
=end 
# this update function is not necessary - its the same as create_new_set
=begin
	def self.update_set(new_questions_ids, test_id)

		new_questions.each do |q_id| 
			q_set = QuestionSet.new(test_id: test_id, question_id: q_id) 
			if q_set.save 
			
				print "\n question #{q_id} was added to question set. Test id is #{test_id}\n"
			else 
				print "\n question #{q_id} was not added to question set. Test id is #{test_id} \n"
			end 
		end 
	end 
=end 	
end