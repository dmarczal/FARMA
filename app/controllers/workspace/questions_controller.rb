class Workspace::QuestionsController < Workspace::DashboardController
  include FindModels

  before_action :find_question, only: [:edit, :update, :destroy]
  before_action :find_exercise, only: [:new, :create, :destroy, :update, :edit]

  def new
    @question = @exercise.questions.new
  end

  def create
    @question = @exercise.questions.new(question_params)
    if @question.save
      redirect_to workspace_lo_exercise_path(@lo, @exercise)
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to workspace_lo_exercise_path(@lo, @exercise)
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to workspace_lo_exercise_path(@lo, @exercise)
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :correct_answer, :precision, :cmas_order)
    end

    def find_question
      find_exercise
      @question = @exercise.questions.find(params[:id])
    end
end
