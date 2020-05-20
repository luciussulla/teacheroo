class StudentsController < ApplicationController

  before_action :set_student, only: [:show]
  before_action :confirm_log_in, only: [:show]
  before_action :verify_student, only: [:show]

  def index
    @students = Student.all 
  end

  def new
    @groups = ["PNJA - I a01 a",
              "PNJA - I a03 b",
              "PNJA - I a04 b",
              "Zaoczne - PNJA - I az04 b",
              "Zaoczne - PNJA - III apz01 b",
              "ZaocznePNJA - I az01 a",
              "ZaocznePNJA - I az02 a"]
    @student = Student.new
  end

  def create    
    print "\n Student params: #{student_params}"
    @student = Student.new(student_params)
    if @student.save 
      flash[:notice] = "Student Created"
    else 
       flash[:notice] = "Student NOT Created"
    end 
    redirect_to student_path(@student)
  end

  def show
    @students_done_tests = @student.group.tests
    @students_pending_tests 
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:password, :login, :name, :group_id, :year)
  end

  def verify_student  
    unless current_teacher
      if current_student != Student.find(params[:id])
        flash[:notice] = "You do not have authorisation to view other user's sites. If this error persists contact the administrator."
        print "\n current user is #{current_student}\n"
        print "\n current user is not the same as the user's profile you request\n"
        redirect_to student_path current_student
        return false 
      end
    end   
  end  
end