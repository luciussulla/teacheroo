class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy, :remove_q_set]
  before_action :set_teacher, only: [:show, :update, :edit, :new, :create, :show, :remove_q_set]

  def index
    @tests = Test.all
  end

  def show
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
    @test.update(test_name: params[:test][:test_name])

    new_questions_ids = params[:test][:new_questions]

    if QuestionSet.create_new_set(new_questions_ids, @test.id) 
      flash[:notice] = "Updating completed"
      else 
       flash[:notice] = "Updating NOT completed"
       render :edit
    end 
      redirect_to edit_teacher_test_path(@teacher, @test)
  end

  def remove_q_set
    q_set_in_test = @test.question_sets.where(test_id: @test.id)
    q_set_array = q_set_in_test.where(question_id: params[:q_id])

    QuestionSet.destroy_those_q_sets(q_set_array)
    redirect_to edit_teacher_test_path(@teacher, @test)
  #    redirect_to teacher_question_sets_path(@teacher)
  end 

  def delete 
    @questions = @test.questions
    # QuestionSet.delete_questions_from_set(params[:test][:questions])
  end 

  def destroy
    if @test.destroy
      flash[:notice] = "Destroying completed"
    else 
      flash[:notice] = "Destroying NOT completed"
    end 
    redirect_to :index
  end

  private 

  def set_test
    @test = Test.find(params[:id])
  end 

=begin
  # For now, were are not really doing any mass_assignment in this controller
  # the function below is not currently being used.  
  def test_params
    params.require(:test).permit(:test_name, questions: [])
  end
=end 

  def set_teacher 
  	@teacher = Teacher.find(params[:teacher_id])
  	#print  "Inside set_teacher. params[:teacher_id] is #{params[:teacher_id]}"
  end 
end
