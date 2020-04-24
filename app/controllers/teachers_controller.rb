class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    @teachers = Teacher.all
  end

  def show
    
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save 
      flash[:notice] = "Teacher created"
    else 
      flash[:notice] = "Teacher NOT created"
    end 
    redirect_to @teacher
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def set_teacher 
    @teacher = Teacher.find(params[:id])
  end
end
