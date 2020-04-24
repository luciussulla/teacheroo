class StudentTestsController < ApplicationController
  
  def index
  	# need to show all student's tests 
  	@student = set_student 
  	@student_tests = StudentTest.find(student_id: @student.id)
  end

  def new 
  	

  end 

  def create

  def show
  	# show one particular studetn's test 
  	@student = set_student
  	@student_test = StudentTest.find_by(:student_id: @student.id)
  end

  def delete

  end

  def destroy
  	# set student 
  	# find test and delete it 
  end

  private 

  def set_student 
  	@student 
  end 	
  def student_test_params
  	params.require(:student).permit(:text_id, :student_id, :grade, :time_taken, :taken_at, :remarks)
  end 	
end
