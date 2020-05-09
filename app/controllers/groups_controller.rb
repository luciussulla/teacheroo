class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index 
    # we only want the currently logged teacher gorups to show
   @groups = Group.all
  end

  def show
    @group_students = @group.students 
  end

  def new
    @students = Student.all
    @group = Group.new
  end

  def create
    print "\n Inside Create \n"
    @group = Group.new(name: params[:group][:name])

    if @group.save 
      flash[:notice] = "\nGroup created"
      print "\n Group was created"
    else 
      flash[:notice] = "\nGroup not created"
      print "\n Group was NOT created"
    end 

    students_ids = params[:group][:students]
    print "\n inside create action student_ids are #{students_ids} \n"
    Group.add_students_to_group(@group, students_ids)

    redirect_to @group
  end

  def edit
    # The edit function so far does not add the possibility to delete students from group. 
    @students = Student.all - @group.students
  end

  def update

    if @group.update_attribute(:name, params[:group][:name])
      flash[:notice] = "Group updated\n"
      print "\n Group was updated\n"
    else 
      flash[:notice] = "\nGroup not updated\n"
      print "\n Group was NOT updated\n"
    end 
    students_ids = params[:group][:students]
    print "\n inside create action student_ids are #{students_ids} \n"

    Group.add_students_to_group(@group, students_ids)

    redirect_to @group
  end

  def destroy
  end

  private
  def set_group 
    @group = Group.find(params[:id])
  end  
  
end