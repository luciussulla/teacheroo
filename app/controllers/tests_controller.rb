class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

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
    @test.test_name = params[:test][:questions][0]

    if @test.save
      flash[:notice] = "Creating completed"
    else 
      flash[:notice] = "Creating NOT completed"
    end 
    # creating the question_set associated with the test 
    question_ids = params[:test][:questions]

	QuestionSet.create_new_set(question_ids, @test.id)

    redirect_to @test
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
end
