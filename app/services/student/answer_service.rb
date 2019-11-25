class Student::AnswerService
  def initialize(question_id, response, answer_tex, team_id, current_user)
    @question_id = question_id
    @response = response
    @team_id = team_id
    @current_user = current_user
    @answer_tex = answer_tex
  end

  def build
    answer = @current_user.answers.new(
      question_id: @question_id,
      response: @response,
      answer_tex: @answer_tex,
      team_id: @team_id
    )

    unless answer.correct
      tips_count = answer.question.tips_counts.new(
        user_id: @current_user.id,
        team_id: @team_id
      )

      tips_count = tips_count.save_or_update
    end

    answer
  end
end
