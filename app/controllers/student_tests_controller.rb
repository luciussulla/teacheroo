class StudentTestsController < ApplicationController
  before_action :set_student, only: [:new, :show]
  before_action :set_test, only: [:new, :show]
  # Those two need to be separate, cause params and routes are different to set_student / set_test
  #before_action :set_show_student, only: [:show]
  #before_action :set_show_test, only: [:show]
  before_action :student_test_params, only: [:create] # this before is not neccessary - delete it later

  # the route to :new and :create actions for this controller are:
  # get "studentstests/new/:student_id/:test_id", to: "student_tests#new", as: :take_exam 
  # post "/build", to: "student_tests#create"
  def index
  	# need to show all student's tests 
  	#@student_tests = StudentTest.find(student_id: @student.id)
  end

  def new  
    # route to :new is:
    # get "studentstests/new/:student_id/:test_id", to: "student_tests#new", as: :take_exam 
    # params permitted are {:student_id, :test_id}
    # Question object has_many --> QuestionSet object --> Test object has_one --> StudentTest has_many ---> QuestionAnswer belongs to-> Answer
    # A test completed by a student is composed by StudentTest object that has_many QuestionAnswer objects.
    # In the new action we iterate through @test.questions
    # To the controller's create action we send answers (strings) and questions ids 
    # we create an answer object
    # We extract the newly created answer object's id and combine it with question id add student_test_id
    # and save as QuestionAnswer object
    # StudentTest is thus formed by many QuestionAnswer objects. 
    # @student_test = StudentTest.new(test_id: @test.id, student_id: @student.id)
    # @question_answer = QuestionAnswer.new(test_id: @test.id, student_id: @student.id, studetnt_test_is: @student_test.id)
    # We need to extract both student and student_test ids from params 

    test_id = @test.id 
    student_id = @student.id
    @new_student_test = StudentTest.join_student_and_test(test_id, student_id)
    @test_questions = @test.questions 
  end 

  def create 
    # we are retireving the id of the newly creates StudentTest without questionanswer object 
    # to be able to redirect to the student_test_path (show action) after the new test with question_answer objects 
    # is created.
    @student_test_without_question_answers = StudentTest.find(student_test_params[:student_test_id])
    @student = @student_test_without_question_answers.student
    @test = @student_test_without_question_answers.test 
    # create_student_test class method joins the student test with question_answer obeject is the question_naswer table
    # which storest student_test_id, question_id and answer_id (answers are also created inside the function)
    StudentTest.create_student_test(student_test_params) # This function should be changed to "complete_student_test"
    # redirect to student's show page 
    redirect_to show_completed_test_path(@student.id, @test.id)
  end 

  def show
  	# show one particular studetn's test 
    # @student_test_without_question_answers is an ARRAY - must apply first
  	@student_test_without_question_answers = StudentTest.where(student_id: @student.id, test_id: @test.id).first
    # now we find all the question_answers associated with particular user test
    @question_answers = @student_test_without_question_answers.question_answers
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
  	params.require(:student_test).permit(:student_id, :test_id, :student_test_id, {answers: [answer: [:content, :question_id]]})
  end 

end
