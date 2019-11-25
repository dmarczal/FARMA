class API::LosController < API::ApplicationController
  def show
    lo = Lo.find params[:id]
    page = params[:page].to_i
    service = Student::LoTestService.new lo, page, answers

    self.data_type = 'Content[]'
    self.status_response = :ok
    self.data = service.data

    json_response
  end

  def test
    answer = Answer.new(
      question_id: params[:question_id],
      response: params[:response],
      answer_tex: params[:answer_tex],
      test: true
    )

    if answer.valid?
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
        'correct'    => answer.correct,
        'tries'      => tries
      }

      answers[params[:question_id]].push(answer)
      lo = Lo.find params[:lo_id]
      page = params[:page].to_i

      service = Student::LoTestService.new lo, page, answers
      cookies[:answers] = JSON.generate(answers)

      self.data_type = 'Content[]'
      self.status_response = :ok
      self.data = service.data

      json_response
    else
      self.data_type = 'Bad request'
      self.error = answer.errors
      self.status_response = :bad_request

      bad_request_response
    end
  end

  private

  def answers
    json_answers = cookies[:answers];

    return {} if json_answers.nil?

    JSON.parse(json_answers);
  end
end
