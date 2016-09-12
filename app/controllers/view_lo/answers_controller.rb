class ViewLo::AnswersController < ViewLo::ApplicationController

  def create
    data = question_id: params[:question_id], response: params[:response]
    @answer = current_user.answers.new data

    unless @answer.correct
      tips_count = @answer.question.tips_counts.new(
                                  user_id: current_user.id,
                                  team_id: params[:team_id],
                                  tries: @answer.attempt_number)
      tips_count.save

      @tips = @answer.question.tips.order(:number_of_tries).limit(tips_count.tries)
    end

    @answer.save
  end
end
