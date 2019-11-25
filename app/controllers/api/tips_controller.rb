class API::TipsController < API::AuthenticateController
  before_action :find_exercise
  before_action :find_question
  before_action :find_tip, except: [:create, :index]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    if (@exercise.nil?)
      self.data_type = 'O exercício não foi encontrado'
    elsif (@question.nil?)
      self.data_type = 'A questão não foi encontrada'
    else
      self.data_type = 'A dica não foi encontrada'
    end

    not_found_response
  end

  def index
    data = @question.tips.order(:number_of_tries).all

    self.data_type = 'Tip[]'
    self.status_response = :ok
    self.data = serializable_resource.new(data, each_serializer: TipSerializer)

    json_response
  end

  def show
    self.status_response = :ok
    self.data = serializable_resource.new(@tip, serializer: TipSerializer)

    json_response
  end

  def create
    tip = @question.tips.new(tips_params)

    if tip.save
      self.status_response = :created
      self.data = serializable_resource.new(tip, serializer: TipSerializer)

      json_response
    else
      self.data_type = 'Bad request'
      self.error = tip.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  def update
    if @tip.update(tips_params)
      self.status_response = :created
      self.data = serializable_resource.new(@tip, serializer: TipSerializer)

      json_response
    else
      self.data_type = 'Bad request'
      self.error = @tip.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  def destroy
    @tip.destroy

    self.data_type = 'Message'
    self.data = "Dica deletada com sucesso"
    self.status_response = :ok

    json_response
  end

  protected

  def question_param
    params[:question_id]
  end

  def exercise_param
    params[:exercise_id]
  end

  private

  def tips_params
    params.permit(:content, :number_of_tries)
  end

  def find_tip
    @tip = @question.tips.find(params[:id])
  end

  def set_data_type
    self.data_type = 'Tip'
  end
end
