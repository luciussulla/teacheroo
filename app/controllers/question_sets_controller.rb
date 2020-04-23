class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  def index
    unless QuestionSet.all.empty?
      @question_set = QuestionSet.all.order("created_at")
    end 
  end

  def show
  end


  def new
    @questions = Question.all
    @question_set = QuestionSet.new
  end

  def create
    @question_set = QuestionSet.new(question_set_params)
    if @question_set.save
      flash[:notice] = "Creating completed"
    else 
      flash[:notice] = "Creating NOT completed"
    end 
    redirect_to :show
  end


  def edit
  end

  def update
     if @question_set.update(question_set_params)
      flash[:notice] = "Updatingcompleted"
    else 
      flash[:notice] = "UpdatingNOT completed"
      render :edit
    end 
    redirect_to :show
  end

  def destroy
    if @question_set.destroy
      flash[:notice] = "Destroying completed"
    else 
      flash[:notice] = "Destroying NOT completed"
    end 
    redirect_to :index
  end

  private 

  def set_question_set 
    @question_set = QuestionSet.find(params[:id])
  end 

  def question_set_params
    params.require(:question_set).permit(questions: [])
  end
end
