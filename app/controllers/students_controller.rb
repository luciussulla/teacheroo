class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]


  def index
    @students = Student.all 
  end

  def new
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
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:password, :login, :name, :group_id, :year)
  end
end
