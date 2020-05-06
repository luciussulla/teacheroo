class StudentTestsController < ApplicationController
  before_action :set_student, only: [:new]
  before_action :set_test, only: [:new]
  before_action :student_test_params, only: [:create]
  validates_uniqueness_of :student_id, scope: :test_id

  def index
  	# need to show all student's tests 
  	#@student_tests = StudentTest.find(student_id: @student.id)
  end

  def new  
    # Question object --> QuestionSet object --> Test object has_one --> StudentTest has_many ---> QuestionAnswer belongs to-> Answer
    # A test completed by a student is composed by StudentTest object that has_many QuestionAnswer objects.
    # In the show action we iterate through @test.questions
    # To the controller's create action we send answers (strings) and questions ids 
    # we create an answer object
    # We extract the newly created answer object's id and combine it with question id add student_test_id
    # and save as QuestionAnswer object
    # StudentTest is thus formed by many QuestionAnswer objects. 
    # @student_test = StudentTest.new(test_id: @test.id, student_id: @student.id)
    # We need to extract both student and student_test ids from params 7
    @test_questions = @test.questions 
  end 

  def create 
    # implement a create student test function 
    #raise student_test_params.inspect
    StudentTest.create_student_test(student_test_params)
  end 

  def show
  	# show one particular studetn's test 
  	#@student_test = StudentTest.where(student_id: @student.id, test_??? )
  end

  private 
  def set_student 
  	@student = Student.find(params[:student_id])
  end 	

  def set_test 
    @test = Test.find(params[:test_id])
  end 
  
  def student_test_params
    # If the argument of your param key is an array, you put curly branced in front of it. 
    # If the argument of your param is a hash, you put square bracket in front of it. 
  	params.require(:student_test).permit(:student_id, :test_id, {answers: [answer: [:content, :question_id]]})
  end 

end
