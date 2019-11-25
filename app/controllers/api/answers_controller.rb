class API::AnswersController < API::AuthenticateController
  def create
    answer = answer_service.build
    if answer.save
      lo_service.tip_question= params[:question_id].to_i if !answer.correct

      self.data_type = 'Content[]'
      self.status_response = :ok
      self.data = lo_service.data

      json_response
    else
      self.data_type = 'Bad request'
      self.error = answer.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  private

  def answer_service
    @answer_service ||= Student::AnswerService.new params[:question_id],
                                                   params[:response],
                                                   params[:answer_tex],
                                                   params[:team_id],
                                                   current_user
  end

  def lo_service
    set_team
    @lo_service ||= Student::LoService.new @team,
                                           current_user,
                                           @team.lo,
                                           params[:page].to_i
  end

  def set_team
    @team ||= current_user.teams.find params[:team_id]
  end
end
