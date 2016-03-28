class Workspace::QuestionsController < Workspace::DashboardController
  include FindModels

  before_action -> { find_exercise(params[:exercise_id], params[:lo_id]) }, only: [:new, :create]

  def new
    @question = @exercise.question.new
  end

  def create
    
    @question = @exercise.question.new(question_params)
    if @question.save
      redirect_to [:workspace, @lo, @exercise]
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :correct_answer, :precision, :cmas_order)
    end
end
