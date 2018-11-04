class API::QuestionsController < API::ApplicationController
  before_action :find_question, except: [:create, :index]
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

  private

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
