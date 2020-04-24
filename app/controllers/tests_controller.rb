class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :set_teacher, only: [:new, :create]

  def index
    unless Test.all.empty?
      @tests = Question.all.order("created_at")
    end 
  end

  def show

  end

  def new
  	@test = Test.new
    @questions = Question.all
  end

  def create
    @test = Test.new(test_name: params[:test][:test_name])
    @test.teacher_id = @teacher.id.to_i
    print "\nInside test create. params[:test][:test_name] is #{params[:test][:test_name]}\n"
   	print "\nInside test create inspecting @test: #{@test.inspect}\n\n"

    if @test.save
      flash[:notice] = "Creating completed"
      print "\nindise block @test.save: creating test completed\n\n"
    else 
      flash[:notice] = "Creating NOT completed"
       print "\nindise block @test.save: creating test  NOT completed\n\n"
    end 

    # creating the question_set associated with the test 

    questions_ids = params[:test][:questions]

    print "\n inside test create inspecting questions_ids: #{questions_ids}\n\n"
    print "\n inside test create inspecting @tes.id: #{@test.id}\n\n"

	QuestionSet.create_new_set(questions_ids, @test.id)

    redirect_to [@teacher, @test]
  end 

  def edit
  end

  def update
     if @test.update(test_params)
      flash[:notice] = "Updatingcompleted"
    else 
      flash[:notice] = "UpdatingNOT completed"
      render :edit
    end 
    redirect_to :show
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

  def test_params
    params.require(:test).permit(:test_name, questions: [])
  end

  def set_teacher 
  	@teacher = Teacher.find(params[:teacher_id])
  	print  "Inside set_teacher. params[:teacher_id] is #{params[:teacher_id]}"
  end 
end
