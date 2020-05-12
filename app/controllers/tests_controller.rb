class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy, :remove_q_set]
  before_action :set_teacher, only: [:show, :update, :edit, :new, :create, :remove_q_set]
  before_action :set_teacher_groups, only: [:edit, :update]

  def index
    @tests = Test.all
  end

  def show
    @teacher = @test.teacher
  end

  def new
  	@test = Test.new
    @questions = Question.all
  end

  def create
    @test = Test.new(test_name: params[:test][:test_name])
    @test.teacher_id = @teacher.id
   # print "\nInside test create. params[:test][:test_name] is #{params[:test][:test_name]}\n"
   # print "\nInside test create inspecting @test: #{@test.inspect}\n\n"
    if @test.save
      flash[:notice] = "Creating completed"
    #  print "\n indise block @test.save: creating test completed\n\n"
    else 
      flash[:notice] = "Creating NOT completed"
     #  print "\n indise block @test.save: creating test  NOT completed\n\n"
    end 
    # creating the question_set associated with the test 
    questions_ids = params[:test][:questions]
    #print "\n inside test create inspecting questions_ids: #{questions_ids}\n\n"
    #print "\n inside test create inspecting @tes.id: #{@test.id}\n\n"
	  QuestionSet.create_new_set(questions_ids, @test.id)
    redirect_to [@teacher, @test]
  end 

  def edit
    @questions = @test.questions
    @new_questions = Question.all - @questions
  end

  def update
    # if the proper form with 
    # proper submit button sent the information in params[:commit] == 'Submit' 
    # both the name will be edited and the new_questions_sets will be added
    # if howere the button params[:commit] == Assign was pressed 
    # that means the groups will be assigned test and the 
    # from_assign? will be called 
    test_id = @test.id 
    teacher_id = @teacher.id
    #@teachers_groups_with_test, @teachers_groups_without_test = GroupTest.teachers_groups_test(teacher_id, @test)   

    if from_submit_button? 
      print "\n inside update from submit button?\n"
      @test.update(test_name: params[:test][:test_name])
      new_questions_ids = params[:test][:new_questions]
      if !new_questions_ids.blank?
        if QuestionSet.create_new_set(new_questions_ids, test_id) 
          flash[:notice] = "Updating completed"
        else 
          flash[:notice] = "Updating NOT completed"
         end
      end
    end  

    if from_assign_button?
      print "\n inside update from assign button?\n"
      #need to retrieve the group_ids 
      #need to create the group_tests objects 
      #need to save group_tests objects 
      new_assigned_groups_ids = params[:test][:groups_ids]
      # if !new_assigned_groups_ids.blank? 
        GroupTest.reassign_groups_test(teacher_id, test_id, new_assigned_groups_ids)
      # end  
=begin
      if !groups_ids.blank? 
        if GroupTest.create_group_tests(groups_ids, test_id)+/
          flash[:notice] = "Updating completed"
        else 
          flash[:notice] = "Updating NOT completed"
         end
      end 
=end       
    end

    # regardless of which if block is called the redirect happens here
    redirect_to edit_teacher_test_path(@teacher, @test)
  end

  def remove_q_set
    # this is a custom route to delete custom q set 
    # the link is in the edit view
    # member is created in routes
    q_set_in_test = @test.question_sets.where(test_id: @test.id)
    q_set_array = q_set_in_test.where(question_id: params[:q_id])

    QuestionSet.destroy_those_q_sets(q_set_array)
    redirect_to edit_teacher_test_path(@teacher, @test)
    #  redirect_to teacher_question_sets_path(@teacher)
    # form for this will be created in the edit and will 
    # require special private function to identify the 
    # params from form that come into this function 
    # it is presented here how it's fone: 
  end 

  def take_test 
    # we need the copy of the functionality from the student_test controller and model. 
      @test_questions = @test.questions 
  end 

  def save_completed_test
    # we copy the create part from students_test controller 
  end 

  def show_results

  end 

  def destroy
    if @test.destroy
      flash[:notice] = "Destroying completed"
    else 
      flash[:notice] = "Destroying NOT completed"
    end 
    redirect_to :index
  end

  private #############################################
  
  def set_test
    @test = Test.find(params[:id])
  end 

  def set_teacher 
  	@teacher = set_test.teacher
  	#print  "Inside set_teacher. params[:teacher_id] is #{params[:teacher_id]}"
  end 

  def set_teacher_groups
    @teacher = set_teacher
    @teacher_groups = @teacher.groups
  end 

  # set_teacher_group calls set_teacher which calls set_teacher, so all functions are related. 
  # because in the params we do not have params[:teacher_id]
  
  def from_submit_button? 
    print "\n indide from submit button private function \n"
    print "\n from_submit_button will have the value of #{params[:commit] == 'Submit'}"
    params[:commit] == "Submit"
  end 

  def from_assign_button? 
    print "\n indide from assign button private function \n"
    print "\n from_assign_button will have the value of #{params[:commit] == 'Assign'}"
    params[:commit] == "Assign"
  end 
end
