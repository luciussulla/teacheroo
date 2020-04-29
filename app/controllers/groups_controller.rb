class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index 
    # we only want the currently logged teacher gorups to show
   @groups = Group.all
  end

  def show
  end

  def new
    @students = Student.all
    @group = Group.new
  end

  def create
    print "\n Inside Create \n"
    @group = Group.new(name: params[:group][:name])

    if @group.save 
      flash[:notice] = "Group created"
      print "\n Group was created"
    else 
      flash[:notice] = "Group not created"
      print "\n Group was NOT created"
    end 

    print "\n Group name is #{@group.name}"
    students_ids = params[:group][:students]
    print "\n inside create action student_ids are #{students_ids} \n"
    Group.add_students_to_group(@group, students_ids)

    redirect_to @group
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def set_group 
    @group = Group.find(params[:id])
  end 

  def group_params
=begin  

    pars = params.require(:group).permit(:name, students: [])
    p_hash = {}
    p_hash[:name] = pars[:name]
    p_hash[:students] = pars[:students].collect(&:to_i)
    print "\n p_hash: #{p_hash}"
    p_hash
    print "\n pname #{pname}\n "
    print "\n pstudents #{pstudents}\n"
    pars = pname.merge(pstudents)
    print "\n pars studetns #{pars} \n" 
=end    
  end 
end