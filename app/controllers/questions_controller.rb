class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :edit, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end
  
  def show
  end 

  def create
    if @question = Question.create(question_params)
      flash[:notice] = "Question created"
      redirect_to root_path
    else 
      flash[:notice] = "Question NOT created"
      redirect_to root_path
     end  
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private 

  def question_params
    params.require(:question).permit(:option1, :option2, :option3, :option4, :content, :correct_answer)    
  end 

  def set_question
    @question = Question.find(params[:id])
  end 

end


