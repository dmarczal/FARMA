class API::LosController < API::ApplicationController
  def show
    lo = current_user.los.find params[:id]
    page = params[:page].to_i
    service = Student::LoTestService.new lo, page, answers

    self.data_type = 'Content[]'
    self.status_response = :ok
    self.data = service.data

    json_response
  end

  private

  def answers
    json_answers = cookies[:answers];

    return {} if json_answers.nil?

    JSON.parse(json_answers);
  end
end
