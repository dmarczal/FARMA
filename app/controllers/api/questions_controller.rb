class API::QuestionsController < API::ApplicationController
  before_action :find_question, except: [:create, :index, :load_student_questions]
  before_action :set_data_type

  rescue_from ActiveRecord::RecordNotFound do |exception|
    if (@exercise.nil?)
      self.data_type = 'O exercício não foi encontrado'
    else
      self.data_type = 'A questão não foi encontrada'
    end

    not_found_response
  end

  def index
    data = @exercise.questions.order(:position).all

    self.data_type = 'Question[]'
    self.status_response = :ok
    self.data = serializable_resource.new(data, each_serializer: QuestionSerializer)

    json_response
  end

  def show
    self.status_response = :ok
    self.data = serializable_resource.new(@question, serializer: QuestionSerializer)

    json_response
  end

  def create
    question = @exercise.questions.new(question_params)

    if question.save
      self.status_response = :created
      self.data = serializable_resource.new(question, serializer: QuestionSerializer)

      json_response
    else
      self.data_type = 'Bad request'
      self.error = question.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  def update
    if @question.update(question_params)
      self.status_response = :created
      self.data = serializable_resource.new(@question, serializer: QuestionSerializer)

      json_response
    else
      self.data_type = 'Bad request'
      self.error = @question.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  def destroy
    title = @question.title
    @question.destroy

    self.data_type = 'Message'
    self.data = "Questão #{title} deletada com sucesso"
    self.status_response = :ok

    json_response
  end

  def load_student_questions
    data = @exercise.questions.order(:position).all
    data = data.map { |q| data_student_questions(q) }

    self.data_type = 'Hash'
    self.data = { questions: data, progress: progress_los }
    self.status_response = :ok

    json_response
  end

  def test_answer
    answer = current_user.answers.new(
      test: true,
      question_id: @question.id,
      response: params[:response]
    )

    tries = calc_tries

    data = {
      tries: tries,
      answer: answer,
    }

    unless answer.correct
      tips = tips(tries)
      tip = tips.last

      data[:tips] = tips
      data[:tip] = tip
    end

    self.data_type = 'Answer'
    self.data = data
    self.status_response = :ok

    json_response
  end

  def reset_tries
    cookies.delete("count_responses_#{@question.id}")

    self.data_type = 'No Content'
    self.data = ''
    self.status_response = :no_content

    json_response
  end

  private

  def progress_los
    @progress_los ||= @exercise.lo.progress_los
  end

  def team
    @team ||= current_user.teams.find(params[:team_id])
  end

  def answers(question)
    @answers ||= Answer.where(user_id: current_user.id, question_id: question.id, team_id: team.id)
  end

  def tips(tries)
    @question.tips_to_show(tips_count: tries)
  end

  def data_student_questions(question)
    tips = question.tips_to_show(user: current_user, team: team)

    {
      tips: tips,
      answers: answers(question),
      question: {
        id: question.id,
        title: question.title,
        content: question.content
      }
    }
  end

  def calc_tries
    if cookies["count_responses_#{@question.id}"].nil?
      cookies["count_responses_#{@question.id}"] = 1
      return 1
    end

    cookies["count_responses_#{@question.id}"] = cookies["count_responses_#{@question.id}"].to_i + 1

    return cookies["count_responses_#{@question.id}"].to_i
  end

  def question_params
    params.permit(:title, :content, :correct_answer, :precision)
  end

  def find_question
    @question = @exercise.questions.find(params[:id])
  end

  def set_data_type
    self.data_type = 'Question'
  end
end
