class Teacher::QuestionsController < Teacher::ApplicationController
  include FindModels

  before_action :find_question, except: [:new, :create]
  before_action :find_exercise, only: [:new, :create]

  def show
    cookies.delete("count_responses_#{@question.id}")
    @tips = @question.tips.order :number_of_tries
    @action = teacher_lo_exercise_question_test_to_answer_path(@lo, @exercise, @question)
  end

  def new
    @class = "cancel-new-question"
    @remote = true
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

  def test_to_answer
    @class_correct = 'valid'
    @answer = current_user.answers.new(test: true,
                    question_id: @question.id,
                    response: answer_params[:response]
    )

    unless @answer.correct
      @class_correct = 'invalid'

      if cookies["count_responses_#{@question.id}"].nil?
        cookies["count_responses_#{@question.id}"] = 1
      else
        cookies["count_responses_#{@question.id}"] = cookies["count_responses_#{@question.id}"].to_i + 1
      end

      @tips = @question.tips_to_show(tips_count: cookies["count_responses_#{@question.id}"].to_i)
      @tip = @tips.last
      @tips_count = cookies["count_responses_#{@question.id}"].to_i
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :correct_answer, :precision, :cmas_order)
    end

    def answer_params
      params.require(:answer).permit(:response)
    end
end
