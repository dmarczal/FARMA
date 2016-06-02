class Teacher::QuestionsController < Teacher::ApplicationController
  include FindModels

  before_action :find_question, except: [:new, :create]
  before_action :find_exercise, only: [:new, :create]

  def show
    @tips = @question.tips.order :number_of_tries
  end

  def new
    @class = "cancel-new-question"
    @remote = true;
    @question = @exercise.questions.new
  end

  def create
    @question = @exercise.questions.new(question_params)

    if @question.save
      flash.now[:notice] = "Questão #{@question.title} criada."
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def edit
    @class = "btn-cancel-question"
    @remote = false
  end

  def update
    if @question.update(question_params)
      flash.now[:notice] = "Questão #{@question.title} editada."
      redirect_to teacher_lo_exercise_path @lo, @exercise
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to teacher_lo_exercise_path(@lo, @exercise)
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :correct_answer, :precision, :cmas_order)
    end
end
