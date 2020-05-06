class StudentTest < ApplicationRecord
  belongs_to :test
  belongs_to :student
  has_many :question_answers
  has_many :answers, through: :question_answers
  validates_uniqueness_of :student_id, scope: :test_id

  # This is for tomorrow 
  # def self.initialize_student_test(student, test)
    # this function is run in the new action, to prepare the student_test. 
  #end

  def self.join_student_and_test(test_id, student_id)
    student_test = StudentTest.new(test_id: test_id, student_id: student_id)
    if student_test.save  
      print "\nStudentTest has been created\n" 
    else 
      print "\nA student_test has not been created\n"
    end
    student_test
  end 

  def self.save_answer_add_question_answer(answer, student_test_id, question_id) 
    if answer.save 
        #raise answer.inspect
        print "\nAnswer has been created\n"
        # here we join the answer_id, question_id and the student_test_id in a new question_anwer object
        # this should be done by separate function 
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

  def self.create_new_question_answers(student_test, answers_array)
    student_test_id = student_test.id

    answers_array.each do |answer_hash| 
      answer_content = answer_hash["answer"]["content"]
      question_id = answer_hash["answer"]["question_id"]
      answer = Answer.new(content: answer_content)
      
      save_answer_add_question_answer(answer, student_test_id, question_id)  
    end
  end 

  def self.create_student_test(student_test_params)
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
    test_id = student_test_params[:test_id] 
    student_id = student_test_params[:student_id]

    student_test = join_student_and_test(test_id, student_id)
  	answers_array = student_test_params[:answers]

    create_new_question_answers(student_test, answers_array)
  end 

=begin  
  accepts_nested_attributes_for :answers

  def answer=(answer)
  	@answer = answer
  end

  def question_id=(question_id)
  	@question_id = question_id
  end 

  def content=(content)
  	@content = content
  end 
=end 
end
