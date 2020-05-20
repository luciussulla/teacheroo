class StudentTest < ApplicationRecord
  belongs_to :test
  belongs_to :student
  has_many :question_answers
  has_many :answers, through: :question_answers
  validates_uniqueness_of :student_id, scope: :test_id
  
  module SolveTest
    def self.join_student_and_test(test, student)
      # This function needs to be called in the new action 
      # then the @new_student_test's id needs to be passed as hidden in params to create_student_test function
      # params need to be changed from what they are now 
      # instead of passing student_id and test_id to the params in create function we just pass the 
      # student_test_id - that's all we need to create new QuestionAnswer obejcts 
      print "\n test is #{test.inspect} and student is: #{student.inspect}\n"
      student_test = StudentTest.new(test_id: test.id, student_id: student.id)
      if student_test.save  
        print "\nStudentTest has been created\n" 
      else 
        print "\nA student_test has not been created\n"
      end
      student_test
    end 

    def self.save_answer_create_question_answer(answer, student_test_id, question_id) 
      if answer.save 
          print "\nAnswer has been created\n"
          question_answer = QuestionAnswer.new(student_test_id: student_test_id, question_id: question_id, answer_id: answer.id)
          if question_answer.save
            print "\nQuestionAnswer was created\n"
          else 
            print "\nQuestionAnswer not created\n"
          end   
      else 
          print "\nAnswer has not been created\n"
      end   
    end 

    def self.build_new_question_answers(student_test_id, answers_array)
      answers_array.each do |answer_hash| 
        answer_content = answer_hash["answer"]["content"].gsub(/\s+/,'')
        question_id = answer_hash["answer"]["question_id"]
        answer = Answer.new(content: answer_content)
        
        save_answer_create_question_answer(answer, student_test_id, question_id)  
      end
    end 

    def self.fill_in_student_test(student_test_params)
    	# There is no single CompletedTest object! 
    	# A completed test is a StudentTest object that has_many QuestionAnswer objects
    	# Creating a completed test requires student_id and test_id as well as the answer ids
    	# First we create the StudentTest object 
    	# Then we create the Answer objects, from the answers provided by students 
    	# Thirdly we can finally create the QuestionAnswer objects with a link to StudentTest object
    	#
      # student_test_params look like this: 
  	  #{"student_id"=>"1",
      # "test_id"=>"26",
      # "answers"=>[
      #	{"answer"=>{"content"=>"a", "question_id"=>"1"}}, 
      #	{"answer"=>{"content"=>"b", "question_id"=>"2"}},
      #	{"answer"=>{"content"=>"c", "question_id"=>"3"}}
     	# ]
     	#}
    	answers_array = student_test_params[:answers]
      student_test_id = student_test_params[:student_test_id]
      build_new_question_answers(student_test_id, answers_array)
    end 
  end 

  module CheckTest 
    def self.check(test, question_answers_array)
      # .test_duration function checks how long it took to take the test and puts the minutes value
      self.test_duration(test)

      number_of_questions = question_answers_array.length
      print "\n number of questions is #{number_of_questions} \n"
      points = 0

      question_answers_array.each do |qa|
        correct_answer = Question.find(qa.question_id).correct_answer
        student_answer = Answer.find(qa.answer_id).content
        print "\n correct_answer is #{correct_answer}\n"
         print "\n student answer is answer is #{student_answer}\n"
        if correct_answer === student_answer 
          points += 1
          print "\n number of points is #{points}\n"
        end 
      end 

      percentage = ((points.to_f / number_of_questions.to_f).round(2) * 100)
      print "\n Points #{points}\n"
      print "\n Percentage #{percentage}\n"
  
      case percentage
        when 0..60 then test.update_attribute(:grade,2)
        when 61..70 then test.update_attribute(:grade,3)
        when 71..75 then test.update_attribute(:grade, 3.5.to_f)
        when 75..85 then test.update_attribute(:grade,4)
        when 86..91 then  test.update_attribute(:grade, 4.5.to_f)
        when 90..100 then test.update_attribute(:grade, 5.to_f)
        else raise "Invalid input".inspect
      end 

      if test.grade?
        print "\n The grade of #{test.grade} was successfully updated \n"
      else 
       print "\n The grade of #{test.grade} was NOT successfully updated \n"  
      end  
      results_hash = {percentage: percentage, grade: test.grade, points: points}
    end

    def self.test_duration(test)
      minutes_taken = ((Time.now - test.created_at)/60).round(0)
      print "\n Time taken for test is #{minutes_taken}\n"
      if test.update_attribute(:time_taken, minutes_taken)
        print "\n time_taken attribute updated \n"
      else 
        print "\nProblem updating the test time_taken attribute \n"
      end 
    end 
  end 

=begin
````#question_answer model
    t.integer "question_id", null: false
    t.integer "answer_id", null: false
    t.integer "student_test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false

    # test model 
    t.integer "test_id", null: false
    t.integer "student_id", null: false
    t.integer "grade"
    t.integer "time_taken"
    t.datetime "taken_at"
    t.string "remarks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
=end
end
