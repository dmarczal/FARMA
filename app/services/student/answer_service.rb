class Student::AnswerService
  def initialize(question_id, response, team_id)
    @question_id = question_id
    @response = response
    @team_id = team_id
  end

  def build
    answer = current_user.answers.new(
      question_id: params[:id],
      response: params[:response],
      team_id: team.id
    )

    unless answer.correct
      tips_count = answer.question.tips_counts.new(
        user_id: current_user.id,
        team_id: team.id
      )

      tips_count = tips_count.save_or_update
    end

    answer
  end
end
