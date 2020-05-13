class StudentTestsController < ApplicationController
  before_action :set_student, only: [:new, :show, :results]
  before_action :set_test, only: [:new, :show, :results]

  def new   
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
    # We need to extract both student test and student_test ids from params 
    @new_student_test = StudentTest::SolveTest.join_student_and_test(@test, @student)
    @test_questions = @test.questions 
  end 

  def create 
    @student_test = StudentTest.find(student_test_params[:student_test_id]) # comes from the new action
    @student = @student_test.student 
    @raw_test = @student_test.test 
    @question_answers = @student_test.question_answers
    # .fill_in_student_test joins the student test with question_answer obejects by storing student_test_id, question_id and answer_id 
    # answers are created inside the function
    StudentTest::SolveTest.fill_in_student_test(student_test_params)
    StudentTest::CheckTest.check(@student_test, @question_answers)
    redirect_to action: :results, student_id: @student.id, test_id: @raw_test.id, student_test_id: @student_test.id
  end 

  def results
    @test_with_question_answers = StudentTest.where(student_id: @student.id, test_id: @test.id).first
    @question_answers = @test_with_question_answers.question_answers
    @student_test = StudentTest.find(params[:student_test_id])
  end 
 
  private   
  def set_student 
  	@student = Student.find(params[:student_id])
  end 	

  def set_test 
    @test = Test.find(params[:id])
  end 

  def student_test_params
    # If the argument of your param key is an array, you put curly branced in front of it. 
    # If the argument of your param is a hash, you put square bracket in front of it. 
  	params.require(:student_test).permit(:student_id, :test_id, :student_test_id, {answers: [answer: [:content, :question_id]]})
  end 
end
