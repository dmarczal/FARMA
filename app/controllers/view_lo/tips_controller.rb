class ViewLo::TipsController < ViewLo::ApplicationController

  def show
    @question = Question.find params[:question_id]
    @team = Team.find params[:team_id]
    tip_count = @question.tips_counts.where(team_id: @team.id, user_id: current_user.id)
    @tips = @question.tips.where("number_of_tries <= #{tip_count[0].tries}")
    @tip = Tip.find params[:id]
  end
end
