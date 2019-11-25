class API::AnswersController < API::ApplicationController
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

  def test
    answer = Answer.new(
      question_id: params[:question_id],
      response: params[:response],
      answer_tex: params[:answer_tex],
      test: true
    )

    answers = {}
    json_answers = cookies[:answers]
    answers = JSON.parse(json_answers) if !json_answers.nil?

    answers[params[:question_id]] = [] if answers[params[:question_id]].nil?

    tries = answers[params[:question_id]].length

    unless answer.correct
      tries = tries + 1
    end

    answer = {
      'value'      => answer.response,
      'answer_tex' => answer.answer_tex,
      'correct'     => answer.correct,
      'tries'       => tries
    }

    answers[params[:question_id]].push(answer)
    lo = current_user.los.find params[:lo_id]
    page = params[:page].to_i

    service = Student::LoTestService.new lo, page, answers
    cookies[:answers] = JSON.generate(answers)

    self.data_type = 'Content[]'
    self.status_response = :ok
    self.data = service.data

    json_response
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
