class ViewLo::AnswersController < ViewLo::ApplicationController

  def create
    @class = 'valid'
    @question = Question.find params[:question_id]
    @team = Team.find params[:team_id]

    @answer = current_user.answers.new(
                    question_id: @question.id,
                    response: answer_params[:response],
                    team_id: @team.id
    )

    unless @answer.correct
      @class = 'invalid'
      tips_count = @answer.question.tips_counts.new(
                                  user_id: current_user.id,
                                  team_id: @team.id
      )

      tips_count = tips_count.save_or_update
    end

    @answer.save
  end

  private

  def answer_params
    params.require(:answer).permit(:response)
  end
end
