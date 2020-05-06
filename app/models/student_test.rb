
class StudentTest < ApplicationRecord
  belongs_to :test
  belongs_to :student
  has_many :question_answers
  has_many :answers, through: :question_answers

  def self.create_student_test(student_test_params)
  	# There is not single CompletedTest object! 
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
  	answers_array = student_test_params[:answers]

  	# StudetTest would require a uniqueness constraint

  	student_test = StudentTest.new(test_id: test_id, student_id: student_id)
  	if student_test.save 
  		raise student_test.inspect
  	else 
  		print "A student_test has not been created"
  	 	raise "A student_test has not been created"
  	end 	

  	#raise test_id.inspect 
  	#raise student_id.inspect 
  	#raise answers_array.inspect 
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
